#!/usr/bin/env python

# Copyright 2015 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

import os

def check_browser(browser):
  print("get driver for " + os.environ["SELENIUM_HUB_HOST"])
  driver = webdriver.Remote(
    command_executor='http://' + os.environ["SELENIUM_HUB_HOST"] + '/wd/hub',
    desired_capabilities={"browserName": "chrome"}
  )
  driver.get("http://" + os.environ["BASE_URL"])
  print("got the URL")
  assert "BuildCommit" in driver.page_source
  assert "OC BuildNumber: " + str(os.environ["DEPLOY_BUILD_NUMBER"]) in driver.page_source
  assert "OC BuildCommit: " + str(os.environ["DEPLOY_GIT_COMMIT"]) in driver.page_source
  driver.close()
  print("Browser %s checks out!" % browser)


check_browser("CHROME")
