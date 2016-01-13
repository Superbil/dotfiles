(require 'nnir)

;; ask encyption password once
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(setq gnus-select-method '(nnimap "Superbil"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-stream ssl)
                                  (nnir-search-engine imap)))

;; Make Gnus NOT ignore [Gmail] mailboxes
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; Replace [ and ] with _ in ADAPT file names
;; Fix bug for Gnus v5.13
(setq nnheader-file-name-translation-alist '((?[ . ?_) (?] . ?_)) )

(setq gnus-face-1 'font-lock-keyword-face
      gnus-face-2 'font-lock-doc-face)

(setq-default gnus-summary-line-format "%U%R%z%* %1{%d%} %(%-20,20f %2{%4k%} %B%s%) \n"
              ;; gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
              gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
              gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
              )

(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)))

;; NO 'passive
(setq gnus-use-cache t)
(setq gnus-use-adaptive-scoring t)
(setq gnus-save-score t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)
;; @see http://stackoverflow.com/questions/945419/how-dont-use-gnus-adaptive-scoring-in-some-newsgroups
(setq gnus-parameters
      '(("nnimap.*"
         (gnus-use-scoring nil))
        ))

(defvar gnus-default-adaptive-score-alist
  '((gnus-kill-file-mark (from -10))
    (gnus-unread-mark)
    (gnus-read-mark (from 10) (subject 30))
    (gnus-catchup-mark (subject -10))
    (gnus-killed-mark (from -1) (subject -30))
    (gnus-del-mark (from -2) (subject -15))
    (gnus-ticked-mark (from 10))
    (gnus-dormant-mark (from 5))))

;; (require-package 'bbdb)
;; ;; BBDB: Adress list
;; (when (file-exists-p "/usr/share/emacs/site-lisp/bbdb")
;; (setq gnus-score-find-score-files-function
;;       '(gnus-score-find-hierarchical gnus-score-find-bnews bbdb/gnus-score))
;;   (require 'bbdb)
;;   (bbdb-initialize 'message 'gnus 'sendmail)
;;   (setq bbdb-file (expand-file-name "bbdb.db" gnus-home-directory))
;;   (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;;   (setq bbdb/mail-auto-create-p t
;;         bbdb/news-auto-create-p t)
;;   (defvar bbdb-time-internal-format "%Y-%m-%d"
;;     "The internal date format.")
;;   ;;;###autoload
;;   (defun bbdb-timestamp-hook (record)
;;     "For use as a `bbdb-change-hook'; maintains a notes-field called `timestamp'
;;     for the given record which contains the time when it was last modified.  If
;;     there is such a field there already, it is changed, otherwise it is added."
;;     (bbdb-record-putprop record 'timestamp (format-time-string
;;                                             bbdb-time-internal-format
;;                                             (current-time)))))
;; (add-hook 'message-mode-hook
;;           '(lambda ()
;;              (flyspell-mode t)
;;              (local-set-key "<TAB>" 'bbdb-complete-name)))

;; Fetch only part of the article if we can.
(setq gnus-read-active-file 'some)

;; Tree view for groups.  I like the organisational feel this has.
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a bton!
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.  'gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
;; (setq gnus-thread-hide-subtree t)
;; (setq gnus-thread-ignore-subject t)

;; Personal Information
(setq user-full-name "Superbil"
      user-mail-address "superbil@gmail.com"
      message-generate-headers-first t)

;; Change email address for work folder.  This is one of the most
;; interesting features of Gnus.  I plan on adding custom .sigs soon
;; for different mailing lists.
;; Usage, FROM: My Name <work>
(setq gnus-posting-styles
      '((".*"
         (name "Superbil"
               (address "superbil@gmail.com"
                        (organization "")
                        (signature-file "~/.signature")
                        ("X-Troll" "Emacs is better than Vi")
                        )))))

;;; SMTP
(setq smtpmail-smtp-service 587)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "superbil@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      starttls-use-gnutls t
      smtpmail-local-domain "Fantasy.iMac")

(setq gnus-use-correct-string-widths nil)
