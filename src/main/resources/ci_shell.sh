#!/bin/bash
# filename:ci_shell.sh
# If you run the project in jenkins, please add the following code in "Execute shell"
#

# Define env
export JAVA_HOME=/usr/local/java18
export MAVEN_HOME=/usr/local/apache-maven-3.5.2
export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH
#export MAVEN_OPTS="-Xmx10g -Xms10g -Xmn2g -XX:PermSize=512m -XX:MaxPermSize=512m -XX:ReservedCodeCacheSize=512m -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70"
export MAVEN_OPTS="-Xms2G -Xmx6G"
export LD_LIBRARY_PATH=/usr/local/mpc-0.8.1/lib:/usr/local/gmp-4.3.2/lib:/usr/local/mpfr-2.4.2/lib

echo "========================================================="
echo "WORKSPACE --> $WORKSPACE"
echo "JENKINS_HOME --> ${JENKINS_HOME}"
echo "JOB_NAME --> ${JOB_NAME##*/}-${BUILD_NUMBER}"
echo "========================================================="

BUILD_ERR=126
LIB_DIR=test_lib
MVN_REPO=`git rev-parse --show-toplevel`/.m2/repository


echo "========================================================="
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO Start Extract service jars..\n"

# hadoop, sentry job path
: /opt/meituan/jenkins/workspace/ep_team/tne_test/data_test/sentry-1.8.0_cov
: /opt/meituan/jenkins/workspace/ep_team/tne_test/data_test/mthadoop-2.7.1-hyzs2.0_cov

# hadoop, sentry class path
: /opt/meituan/qa_test/data_bin/sentry-1.8.0_hive-1.2.1_coverage-src/hadoop_cov
: /opt/meituan/qa_test/data_bin/sentry-1.8.0_hive-1.2.1_coverage-src/sentry_cov


# dest jars path
root_dir=/opt/meituan/jenkins/workspace/ep_team/tne_test/data_test
dest_dir=/opt/meituan/qa_test/data_bin/sentry-1.8.0_hive-1.2.1_coverage-src
dest_jars_dirs=$dest_dir/hadoop_sentry_jars
hdp_job_name=mthadoop-2.7.1-hyzs2.0_cov
sentry_job_name=sentry-1.8.0_cov

# clean older residual files
rm -rf $dest_dir/hadoop_cov/* $dest_dir/hadoop_sentry_jars/* $dest_dir/hdp_sentry_classes/* $dest_dir/sentry_cov/* 2 > /dev/null

# find hdfs source code jar and copy them to appropriate directory
hadoop_dir=$root_dir/$hdp_job_name/hadoop-dist/target/hadoop-2.7.1/share/hadoop
#find $hadoop_dir -maxdepth 2 \( -path '/hdfs' -o -path '/common' \) -o \( -name hadoop-hdfs-2.7.1.jar -o -name hadoop-common-2.7.1.jar \) -exec cp -fp \{\} $dest_jars_dirs \;

# find sentry source code jar and copy them to appropriate directory
sentry_dir=$root_dir/$sentry_job_name/sentry-dist/target/apache-sentry-1.8.0-mt-SNAPSHOT-bin/apache-sentry-1.8.0-mt-SNAPSHOT-bin/lib
find $sentry_dir -iregex '.*sentry-service-\(client\|server\)-.*\.jar\|.*sentry-\(provider-db-\|hdfs-service\).*\.jar' -exec cp -fp \{\} $dest_jars_dirs \;

# extract all class from dest jars to appropriate directory
for f in $dest_jars_dirs/*.jar
do
    filename=$(basename $f)
    if [[ ${filename/hadoop/} != $filename ]]; then
        echo extracting `basename $f` to appropriate directory..
        jar_dir=$dest_dir/hadoop_cov/`basename ${f%.*r}`
        mkdir -p $jar_dir && cp -fp $f $jar_dir && \
        unzip -o $jar_dir/`basename $f` -d $jar_dir
        echo
    elif [[ ${filename/sentry/} != $filename ]]; then
        echo extracting `basename $f` to appropriate directory..
        jar_dir=$dest_dir/sentry_cov/`basename ${f%.*r}`
        mkdir -p $jar_dir && cp -fp $f $jar_dir && \
        unzip -o $jar_dir/`basename $f` -d $jar_dir
        echo
    else
       echo "Please confirm the correctness of the hadoop and sentry jars.."
    fi
done

# copy all class to the class directory
classes_dir=/opt/meituan/qa_test/data_bin/sentry-1.8.0_hive-1.2.1_coverage-src/hdp_sentry_classes

if [ -d "$classes_dir" ]; then
    echo "$classes_dir already exists. Re-creating $classes_dir"
    rm -rf $classes_dir && mkdir -p $classes_dir
else
    echo "Creating $classes_dir"
    mkdir -p $classes_dir
fi

find $dest_dir \( -path '/hadoop_cov' -o -path '/sentry_cov' \) -o -name '*.class' -exec cp -fp \{\} $classes_dir \;

echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO End Extract service jars..\n"
echo "========================================================="


# Launch sentry service with agent patch
SERVICE_FILE=/opt/meituan/versions/sentry-1.8.0-package/scripts/plus/run.sh

sed -ri 's/-Djute.maxbuffer=[0-9]+/& -javaagent:\/opt\/meituan\/qa_test\/jacocoagent.jar=output=tcpserver,port=6300,address=*/' ${SERVICE_FILE}
kill -9 $(awk '{print $2}' <<< `ps aux | grep [S]entry`) && \
echo "Service is already started with agent patch successfully." && sleep 6 || exit 127
echo -n `/usr/sbin/lsof -i:6300 | grep -qi listen` && echo "Port is already opened." || exit 128


# Clean code coverage data
GIT_ADDR=ssh://git@git.sk.com/~zhaobin/architect-env-coverage.git
PLUS_NAME=meituan.data.hadoop.sentry
HOST_IP=10.20.94.3
BRANCH_NAME=1.8.0

cd $WORKSPACE
coverage_dir=architect-env-coverage
[ -d "$coverage_dir" ] && rm -rf "$coverage_dir"

git clone $GIT_ADDR
cd architect-env-coverage && git checkout --track origin/plus-master
python lib/CoverageMaster.py -n $PLUS_NAME -t test -a clean -i $HOST_IP -b $BRANCH_NAME


echo "========================================================="
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO Start Build..\n"
cd $WORKSPACE && mvn -Dmaven.repo.local=$MVN_REPO clean test-compile || exit $BUILD_ERR
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO End Build..\n"
echo "========================================================="

# Check dependent libarary directory
cd $WORKSPACE
if [ -d "$LIB_DIR" ]; then
    echo "$LIB_DIR already exists. Re-creating $LIB_DIR"
    rm -rf $LIB_DIR && mkdir $LIB_DIR
else
	echo "Creating $LIB_DIR"
    mkdir $LIB_DIR
fi

# Copy dependent libraries
cp -rp $MVN_REPO/junit/junit/4.12/junit-4.12.jar $LIB_DIR
cp -rp $MVN_REPO/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar $LIB_DIR
cp -rp $MVN_REPO/com/tngtech/java/junit-dataprovider/1.13.1/junit-dataprovider-1.13.1.jar $LIB_DIR
cp -rp $MVN_REPO/com/alibaba/fastjson/1.2.40/fastjson-1.2.40.jar $LIB_DIR
cp -rp $MVN_REPO/log4j/log4j/1.2.17/log4j-1.2.17.jar $LIB_DIR
cp -rp $MVN_REPO/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar $LIB_DIR
cp -rp $MVN_REPO/org/slf4j/slf4j-log4j12/1.7.25/slf4j-log4j12-1.7.25.jar $LIB_DIR

echo "========================================================="
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO Start Run sentry hive1.2 Test..\n"
/usr/bin/time -f "Time: %U" bash ./src/main/resources/sentry_dispatcher.sh
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO End Run sentry hive1.2 Test..\n"
echo "========================================================="


# Dump code coverage
CLASS_DIR=/opt/meituan/qa_test/data_bin/sentry-1.8.0_hive-1.2.1_coverage-src/hdp_sentry_classes
python architect-env-coverage/lib/CoverageMaster.py -n $PLUS_NAME -t test -a dump -c $CLASS_DIR -j ${JOB_NAME##*/} -i $HOST_IP -b $BRANCH_NAME

# Recover sentry service without agent patch
sed -ri 's/(-Djute.maxbuffer=[0-9]+).*(")/\1\2/' ${SERVICE_FILE}
kill -9 $(awk '{print $2}' <<< `ps aux | grep [S]entry`) && \
echo "Service is already started without agent patch successfully." && sleep 6 || exit 129
