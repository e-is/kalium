/**
 * Copyright 2013 Bruno Oliveira, and individual contributors
 * <p/>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p/>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p/>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.abstractj.kalium;

import org.junit.Test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class NaClTest {

    @Test
    public void testSodiumLoads() {
        try {
            NaCl.Sodium sodium = NaCl.sodium();
            assertNotNull("Sodium instance should not be null", sodium);
        } catch (UnsupportedOperationException e) {
            fail("Should not throw UnsupportedOperationException: " + e.getMessage());
        }
    }

    @Test
    public void testSodiumVersionString() {
        NaCl.Sodium sodium = NaCl.sodium();
        String version = sodium.sodium_version_string();
        assertNotNull("Version string should not be null", version);
        assertTrue("Version string should not be empty", version.length() > 0);
        // Version should start with a digit
        assertTrue("Version should start with a digit", Character.isDigit(version.charAt(0)));
    }

    @Test
    public void testSodiumInit() {
        int result = NaCl.init();
        // sodium_init() returns 0 on success, 1 if already initialized, -1 on error
        assertTrue("Sodium init should return 0, 1, or -1", result >= -1 && result <= 1);
    }

    @Test
    public void testMultipleSodiumCalls() {
        // Test that multiple calls return the same instance (singleton)
        NaCl.Sodium sodium1 = NaCl.sodium();
        NaCl.Sodium sodium2 = NaCl.sodium();
        assertNotNull("First sodium instance should not be null", sodium1);
        assertNotNull("Second sodium instance should not be null", sodium2);
        // They should be the same instance due to singleton pattern
        assertTrue("Multiple calls should return the same singleton instance",
                   sodium1 == sodium2);
    }
}
