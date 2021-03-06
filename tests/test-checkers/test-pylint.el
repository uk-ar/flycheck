;;; test-pylint.el --- Test the pylint checker -*- lexical-binding: t; -*-

;; Copyright (c) 2013 Sebastian Wiesner <lunaryorn@gmail.com>
;;
;; Author: Sebastian Wiesner <lunaryorn@gmail.com>
;; URL: https://github.com/lunaryorn/flycheck

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ert)
(require 'flycheck)

(require 'python)

(ert-deftest checker-python-pylint-syntax-error ()
  "Test a real syntax error with pylint."
  :expected-result (flycheck-testsuite-fail-unless-checker 'python-pylint)
  (flycheck-testsuite-should-syntax-check
   "syntax-error.py" 'python-mode '(python-flake8 python-pyflakes)
   '(6 nil "invalid syntax" error)))

(ert-deftest checker-python-pylint-missing-quote ()
  "Test a missing quote with pylint."
  :expected-result (flycheck-testsuite-fail-unless-checker 'python-pylint)
  (flycheck-testsuite-should-syntax-check
   "missing-quote.py" 'python-mode '(python-flake8 python-pyflakes)
   '(5 nil "EOL while scanning string literal" error)))

(ert-deftest checker-python-pylint-unknown-module ()
  "Test an unknown module with pylint."
  :expected-result (flycheck-testsuite-fail-unless-checker 'python-pylint)
  (flycheck-testsuite-should-syntax-check
   "unknown-module.py" 'python-mode '(python-flake8 python-pyflakes)
   '(5 nil "Unable to import 'spam'" error)))

(ert-deftest checker-python-pylint-unused-import ()
  "Test an unused import with pylint"
  :expected-result (flycheck-testsuite-fail-unless-checker 'python-pylint)
  (flycheck-testsuite-should-syntax-check
   "unused-import.py" 'python-mode '(python-flake8 python-pyflakes)
   '(5 nil "Unused import re" warning)))

(ert-deftest checker-python-pylint-used-map ()
  "Test usage of the map() builtin with the pylint checker."
  :expected-result (flycheck-testsuite-fail-unless-checker 'python-pylint)
  (flycheck-testsuite-should-syntax-check
   "map-builtin.py" 'python-mode '(python-flake8 python-pyflakes)
   '(5 nil "Used builtin function 'map'" warning)))

;; Local Variables:
;; coding: utf-8
;; End:

;;; test-pylint.el ends here
