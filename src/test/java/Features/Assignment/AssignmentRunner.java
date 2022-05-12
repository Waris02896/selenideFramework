package Features.Assignment;

import com.intuit.karate.junit5.Karate;

public class AssignmentRunner {
    @Karate.Test
    Karate assignment() {
        return Karate.run("Assignment.feature").relativeTo(getClass());
    }
}
