#
#  Copyright 2023 SDKMAN!
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

Feature: Default endpoint security

  Scenario: The default endpoints can NOT be accessed without a valid auth token
    Given the consumer for candidate groovy is making a request
    And the consumer does not have a valid auth token
    And an existing UNIVERSAL groovy version 2.3.5 exists
    And an existing UNIVERSAL groovy version 2.3.6 exists
    And the UNIVERSAL candidate groovy with default version 2.3.5 already exists
    When a JSON PUT on the /candidates/default endpoint:
    """
          |{
          |   "candidate" : "groovy",
          |   "version" : "2.3.6"
          |}
    """
    Then the status received is 403 "FORBIDDEN"

  Scenario: The default endpoints can NOT be accesses by an invalid consumer
    Given the consumer for candidate scala is making a request
    And the consumer has a valid auth token
    And an existing UNIVERSAL groovy version 2.3.5 exists
    And an existing UNIVERSAL groovy version 2.3.6 exists
    And the UNIVERSAL candidate groovy with default version 2.3.5 already exists
    When a JSON PUT on the /candidates/default endpoint:
    """
          |{
          |   "candidate" : "groovy",
          |   "version" : "2.3.6"
          |}
    """
    Then the status received is 403 "FORBIDDEN"

  Scenario: The default endpoints CAN be Accessed when authorised as valid consumer
    Given the consumer for candidate groovy is making a request
    And the consumer has a valid auth token
    And an existing UNIVERSAL groovy version 2.3.5 exists
    And an existing UNIVERSAL groovy version 2.3.6 exists
    And the existing default UNIVERSAL groovy version is 2.3.5
    When a JSON PUT on the /candidates/default endpoint:
    """
          |{
          |   "candidate" : "groovy",
          |   "version" : "2.3.6"
          |}
    """
    Then the status received is 202 "ACCEPTED"

  Scenario: The default endpoints CAN be accessed when authorised as valid list of consumers
    Given the consumer for candidate grails|groovy is making a request
    And the consumer has a valid auth token
    And an existing UNIVERSAL groovy version 2.3.5 exists
    And an existing UNIVERSAL groovy version 2.3.6 exists
    And the existing default UNIVERSAL groovy version is 2.3.5
    When a JSON PUT on the /candidates/default endpoint:
    """
          |{
          |   "candidate" : "groovy",
          |   "version" : "2.3.6"
          |}
    """
    Then the status received is 202 "ACCEPTED"

  Scenario: The default endpoints CAN be accessed when authorised as administrator
    Given the consumer for candidate default_admin is making a request
    And the consumer has a valid auth token
    And an existing UNIVERSAL groovy version 2.3.5 exists
    And an existing UNIVERSAL groovy version 2.3.6 exists
    And the existing default UNIVERSAL groovy version is 2.3.5
    When a JSON PUT on the /candidates/default endpoint:
    """
          |{
          |   "candidate" : "groovy",
          |   "version" : "2.3.6"
          |}
    """
    Then the status received is 202 "ACCEPTED"