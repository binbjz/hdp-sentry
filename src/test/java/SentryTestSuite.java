import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({ServerAll.class, DBInsert.class, DBSelect.class})
public class SentryTestSuite {
}
