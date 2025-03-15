#|
exec sbcl \
  --noinform \
  --disable-debugger \
  --load "$0" \
  --quit \
  --end-toplevel-options "${@:1}"
|#

;;;; 
;;;; ORGANIZE THE DOWNLOADS DIRECTORY
;;;; Author: Joao Mauricio (Jean0t)
;;;;
;;;; Intended to be used in linux systems
;;;; might work on mac as well
;;;;

;; MODULES
(import :uiop)


;; VERIFICATIONS
(if (uiop:os-windows-p) (exit 1))


;; GLOBAL VARIABLES
(defparameter *downloads-directory* (merge-pathnames "Downloads/" (truename (uiop:getenv-pathname "HOME"))))


;; FUNCTIONS
(defun get-extension (file)
  "Return the extension of the file, example foo.tar.gz returns gz"
  (when file 
    (string-downcase (pathname-type (parse-namestring file)))
    nil))

(defun organize-download-dir () ())


;; MAIN
(organize-download-dir)
