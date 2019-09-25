(* SCOM module for Augeas                      *)
(* Author: Chris Wilhelmsen <Christopher.Wilhelmsen@CUAnschutz.edu *)
(*                                            *)

module SCOM =
  autoload xfm

(************************************************************************
 * INI File settings
 *************************************************************************)

let comment  = IniFile.comment IniFile.comment_re IniFile.comment_default
let sep      = IniFile.sep IniFile.sep_re IniFile.sep_default
let empty    = IniFile.empty
let entry    = IniFile.indented_entry IniFile.entry_re sep comment

(************************************************************************
 *                         TITLE
 *
 *************************************************************************)
let title       = IniFile.title ( IniFile.record_re  )
let record      = IniFile.record title entry

(************************************************************************
 *                         LENS & FILTER
 *************************************************************************)
let lns = ( entry | empty )+ . record*
let filter = (incl "/etc/opt/omi/conf/omiserver.conf")
             . Util.stdexcl

let xfm = transform lns filter
