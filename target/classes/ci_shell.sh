#!/usr/bin/env bash
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

# Generate coverage data file
BUILD_ERR=126
LIB_DIR=test_lib
MVN_REPO=`git rev-parse --show-toplevel`/.m2/repository
COVERAGE_OPTIONS="org.jacoco:jacoco-maven-plugin:0.7.9:prepare-agent"

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
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO Start Run entry hive1.2 Test..\n"
/usr/bin/time -f "Time: %U" bash ./src/main/resources/sentry_dispatcher.sh
echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO End Run sentry hive1.2 Test..\n"
echo "========================================================="
