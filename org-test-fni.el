;;;; org-test-fni.el --- Extra tests for Org mode

;; Copyright (C) 2014-2015  Fabrice Niessen

;; Author: Fabrice Niessen

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Command:
;; emacs -Q --batch -L lisp/ -L testing/ -l ~/src/emacs-leuven/org-test-fni.el --eval '(setq org-confirm-babel-evaluate nil)' -f ert-run-tests-batch-and-exit

;;; Code:

(require 'ert)
(require 'ox)

;;; Functions for writing tests

(defun compare-org-html-export-files (orgfile)
  "Compare current export of ORGFILE with HTML file already present on disk."
  (let* ((base-name
          (concat (file-name-directory orgfile) (file-name-base orgfile)))
         (htmlfile (concat base-name ".html"))
         htmlcontents)
    (should
     (equal
      ;; new export
      (with-temp-buffer
        (insert-file-contents orgfile)
        (setq htmlcontents (org-export-as 'html))
        (delete-region (point-min) (point-max))
        (insert htmlcontents)
        (buffer-string))
      ;; old export
      (with-temp-buffer
        (insert-file-contents htmlfile)
        (buffer-string))))))

;;; Internal Tests

(ert-deftest test-org-export/export-html-backend-test-file ()
  "Compare current export of ORGFILE with HTML file already present on disk."
  (compare-org-html-export-files "~/src/emacs-leuven/org-test-sample.org"))

;; (ert 'test-org-export/export-html-backend-test-file)

(ert-deftest test-org-export/export-html-backend-example-file ()
  "Compare current export of ORGFILE with HTML file already present on disk."
  (compare-org-html-export-files "~/src/org-style/example.txt"))

;; (ert 'test-org-export/export-html-backend-example-file)

(ert-deftest test-org-export/export-html-backend-ERT-refcard-file ()
  "Compare current export of ORGFILE with HTML file already present on disk."
  (compare-org-html-export-files "~/src/reference-cards/ERT-refcard.txt"))

;; (ert 'test-org-export/export-html-backend-ERT-refcard-file)

(provide 'org-test-fni)

;;; org-test-fni.el ends here
