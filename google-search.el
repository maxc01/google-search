;;; google-search.el --- Google search thing at point or manually input search item  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Xingchen Ma

;; Author: Xingchen Ma <maxc01@yahoo.com>
;; Keywords: google

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(defvar google-search-history
  nil
  "A list of the previous search terms.")

(defun google-search--read-search-term ()
  "Read a search term from the minibuffer.
If region is active, return that immediately.  Otherwise, prompt
for a string, offering the current word as a default."
  (let (search-term)
    (if (use-region-p)
        (progn
          (setq search-term
                (buffer-substring-no-properties (region-beginning) (region-end)))
          (deactivate-mark))
      (let* ((word (thing-at-point 'word t)))
        (if word
            (setq search-term word)
          (setq search-term
                (read-from-minibuffer "Search item: " nil nil nil 'google-search-history nil)))
        ))
    (unless (equal (car google-search-history) search-term)
      (push search-term google-search-history))
    search-term))

(defun google-search-at-point (term)
  "Start a Google search for TERM."
  (interactive (list (google-search--read-search-term)))
  (let ((url (concat "https://www.google.com/search?q=" term)))
    (browse-url url)))



(provide 'google-search)
;;; google-search.el ends here
