Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 4F99D3857C62
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 11:34:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4F99D3857C62
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfI21-1lelxp0zm7-00glc3 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021
 12:34:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4FD5DA80D7F; Tue, 26 Jan 2021 12:34:41 +0100 (CET)
Date: Tue, 26 Jan 2021 12:34:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/8] syscalls.cc: Implement non-path_conv dependent
 _unlink_nt
Message-ID: <20210126113441.GK4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-5-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-5-ben@wijen.net>
X-Provags-ID: V03:K1:sq7QUc2+jNs7kpBatuGXdD5Psfx13sCUh3XkStb5/lmZcBy1WkM
 C2h+QJQAZRtVGffhKLGkKW+CXjrRqKwf8mzACYKM2p58tC23eQ00VrKGVpsEnnAlyX8kZFy
 Iz0xLpochJvTZPTi0C4Uc3B3zlGi40Pff3u2RmS8AOYov/ZfWJZHO/UucIl5yQ08UU1c/Ok
 a1BO3vLzW8v5MMIe0zfig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DqBUxni+9EU=:Dqw6lO4Xz0VZErOr31eyxi
 hUAYnWnsWcF/oluYWV2YvtH/gQA/OlBpKbOTaRuRlSLBV3f1vXWuUBdeQKrgFywGWV0ayewIN
 3xBO0wHBaa4X+uwzP0No8VQWND1vjbqtoZIen8Jb3bUde26HxsBteDK7daYa4aKJ6yq2/5iR4
 qaMH1ocqnTOcXCbMkcRxGMlfDaoy/ak2EijOFoLWgmzaooKe8Jd/IkCYWdSgqHHjcz8xEphXN
 k1Uhs1+qMRJ+1ZxQy29ycPM3T60SlNsOKUJ7Gae39QdiZseIo+qhIorYxMIMi1OYPQ3XktAIp
 ANjw4oQUAk9LJOSS7D2gBRfenUTB6g1kwdj9xG+5lQjUIwIsxBdhDcjl5hGZJrpW9Bda3oUB7
 P/5w85zTZ7W1I3+S3THoLP+fqJHWxlD9ARHrhMXKuQ1U35HVSN37fCL/60mU3fIyQmUd3uxiT
 JF3FxZPznQ==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 26 Jan 2021 11:34:46 -0000

Hi Ben,

ok, this is strong stuff, and apart from a couple of formatting issues,
we should really discuss if a couple of things are feasible at all.

On Jan 20 17:10, Ben Wijen wrote:
> Implement _unlink_nt: wich does not depend on patch_conv
> ---
>  winsup/cygwin/fhandler_disk_file.cc |   4 +-
>  winsup/cygwin/forkable.cc           |   4 +-
>  winsup/cygwin/syscalls.cc           | 211 ++++++++++++++++++++++++++--
>  3 files changed, 200 insertions(+), 19 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
> index 07f9c513a..fe04f832b 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -1837,7 +1837,7 @@ fhandler_disk_file::mkdir (mode_t mode)
>  int
>  fhandler_disk_file::rmdir ()
>  {
> -  extern NTSTATUS unlink_nt (path_conv &pc);
> +  extern NTSTATUS unlink_ntpc (path_conv &pc);

First of all, the new function should better get a new name.  The _nt
postfix is pretty much historical anyway to differentiate between the
function using Win32 API and the function using NT API.  This is kind
of moot these days sine we're using the NT API almost exclusively for
file access anyway.

So stick to unlink_nt/_unlink_nt for the existing functions, and name
the new function accorind to it's  doings, like, say, unlink_path or
whatever.

> @@ -695,7 +695,157 @@ _unlink_nt_post_dir_check (NTSTATUS status, POBJECT_ATTRIBUTES attr, const path_
>  }
>  
>  static NTSTATUS
> -_unlink_nt (path_conv &pc, bool shareable)
> +_unlink_nt (POBJECT_ATTRIBUTES attr, ULONG eflags)
> +{
> +  static bool has_posix_unlink_semantics =
> +      wincap.has_posix_unlink_semantics ();
> +  static bool has_posix_unlink_semantics_with_ignore_readonly =
> +      wincap.has_posix_unlink_semantics_with_ignore_readonly ();

Did you mean `const' rather than `static', by any chance?  Either way, I
don't think these local vars are required, given that the wincap
accessors are already marked as const.  The compiler should know how to
opimize this sufficiently.

> +
> +  HANDLE fh;
> +  ACCESS_MASK access = DELETE;
> +  IO_STATUS_BLOCK io;
> +  ULONG flags = FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT
> +      | FILE_DELETE_ON_CLOSE | eflags;

This looks like a dangerous assumption.  So far we don't open unknown
reparse points as reparse points deliberately.  No one knows what a
unknown reparse point is good for or supposed to do, so we don't even
know if we are allowed to handle it analogue to a symlink.

Consequentially we open unknown reparse points just as normal files, so
that the reparse point's automatisms may kick in.  By omitting this
step, we're moving on thin ice.

> +  NTSTATUS fstatus, istatus = STATUS_SUCCESS;
> +
> +  syscall_printf("Trying to delete %S, isdir = %d", attr->ObjectName,
> +                 eflags == FILE_DIRECTORY_FILE);
> +
> +  //FILE_DELETE_ON_CLOSE icw FILE_DIRECTORY_FILE only works when directory is empty
> +  //-> We must assume directory not empty, therefore only do this for regular files.

Please use C-style /* ... */ comments in the first place, especially
on multi-line comments.

Also, please keep the line length below 80 chars where possible.

> +  if (eflags & FILE_NON_DIRECTORY_FILE)
> +    {
> +      //Step 1
> +      //If the file is not 'in use' and not 'readonly', this should just work.
> +      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_DELETE, flags);
> +      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
> +    }
> +
> +  if (!(eflags & FILE_NON_DIRECTORY_FILE)    // Workaround for the non-empty-dir issue
> +      || fstatus == STATUS_SHARING_VIOLATION // The file is 'in use'
> +      || fstatus == STATUS_CANNOT_DELETE)    // The file is 'readonly'

I'd drop these comments, the status codes are somewhat self-explaining.

> +    {
> +      //Step 2
> +      //Reopen with all sharing flags, will set delete flag ourselves.
> +      access |= FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES;
> +      flags &= ~FILE_DELETE_ON_CLOSE;
> +      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_VALID_FLAGS, flags);
> +      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
> +
> +      if (NT_SUCCESS (fstatus))
> +        {
> +          if (has_posix_unlink_semantics_with_ignore_readonly)
> +            {
> +              //Step 3
> +              //Remove the file with POSIX unlink semantics, ignore readonly flags.

No check for NTFS?  Posix semantics are not supported on any other FS.
No check for remote?  Just because you support POSIX semantics on
*this* machine, doesn't mean the remote machine supports it at all...

> +              FILE_DISPOSITION_INFORMATION_EX fdie =
> +                { FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS
> +                    | FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE };
> +              istatus = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
> +                                              FileDispositionInformationEx);
> +              debug_printf ("NtSetInformation %S: %y", attr->ObjectName, istatus);
> +
> +              if(istatus == STATUS_INVALID_PARAMETER)
> +                has_posix_unlink_semantics_with_ignore_readonly = false;
> +            }
> +
> +          if (!has_posix_unlink_semantics_with_ignore_readonly
> +              || !NT_SUCCESS (istatus))
> +            {
> +              //Step 4
> +              //Check if we must clear the READONLY flag
> +              FILE_BASIC_INFORMATION qfbi = { 0 };
> +              istatus = NtQueryInformationFile (fh, &io, &qfbi, sizeof qfbi,
> +                                                FileBasicInformation);
> +              debug_printf ("NtQueryFileBasicInformation %S: %y",
> +                            attr->ObjectName, istatus);
> +
> +              if (NT_SUCCESS (istatus))
> +                {
> +                  if (qfbi.FileAttributes & FILE_ATTRIBUTE_READONLY)
> +                    {
> +                      //Step 5
> +                      //Remove the readonly flag
> +                      FILE_BASIC_INFORMATION sfbi = { 0 };
> +                      sfbi.FileAttributes = FILE_ATTRIBUTE_ARCHIVE;
> +                      istatus = NtSetInformationFile (fh, &io, &sfbi,
> +                                                      sizeof sfbi,
> +                                                      FileBasicInformation);
> +                      debug_printf ("NtSetFileBasicInformation %S: %y",
> +                                    attr->ObjectName, istatus);
> +                    }
> +
> +                  if (NT_SUCCESS (istatus))
> +                    {
> +                      //Step 6a
> +                      //Now, mark the file ready for deletion
> +                      if (has_posix_unlink_semantics)
> +                        {
> +                          FILE_DISPOSITION_INFORMATION_EX fdie =
> +                            { FILE_DISPOSITION_DELETE
> +                                | FILE_DISPOSITION_POSIX_SEMANTICS };
> +                          istatus = NtSetInformationFile (
> +                              fh, &io, &fdie, sizeof fdie,
> +                              FileDispositionInformationEx);
> +                          debug_printf (
> +                              "NtSetFileDispositionInformationEx %S: %y",
> +                              attr->ObjectName, istatus);
> +
> +                          if (istatus == STATUS_INVALID_PARAMETER)
> +                            has_posix_unlink_semantics = false;
> +                        }
> +
> +                      if (!has_posix_unlink_semantics
> +                          || !NT_SUCCESS (istatus))
> +                        {
> +                          //Step 6b
> +                          //This will remove a readonly file (as we have just cleared that flag)
> +                          //As we don't have posix unlink semantics, this will still fail if the file is in use.

Without transaction?

> +                          FILE_DISPOSITION_INFORMATION fdi = { TRUE };
> +                          istatus = NtSetInformationFile (
> +                              fh, &io, &fdi, sizeof fdi,
> +                              FileDispositionInformation);
> +                          debug_printf ("NtSetFileDispositionInformation %S: %y",
> +                                        attr->ObjectName, istatus);
> +                        }
> +[...]
> +static bool
> +check_unlink_status(NTSTATUS status)
> +{
> +  //Return true when we don't want to call _unlink_ntpc
> +  return NT_SUCCESS (status)
> +      || status == STATUS_FILE_IS_A_DIRECTORY
> +      || status == STATUS_DIRECTORY_NOT_EMPTY
> +      || status == STATUS_NOT_A_DIRECTORY
> +      || status == STATUS_OBJECT_NAME_NOT_FOUND
> +      || status == STATUS_OBJECT_PATH_INVALID
> +      || status == STATUS_OBJECT_PATH_NOT_FOUND;
> +}
> +
> +static NTSTATUS
> +_unlink_ntpc_ (path_conv& pc, bool shareable)

The trailing underscore should be replaced with a descriptive postfix.

> +{
> +  OBJECT_ATTRIBUTES attr;
> +  ULONG eflags = pc.isdir () ? FILE_DIRECTORY_FILE : FILE_NON_DIRECTORY_FILE;
> +
> +  pc.get_object_attr (attr, sec_none_nih);
> +  NTSTATUS status = _unlink_nt (&attr, eflags);

Sorry, but I don't grok that.  You already have a path_conv, so what's
the advantage of calling the unlink version without path_conv and thus,
without certain check, like the reparse point check, or checks for
filesystems with quirks, like MVFS?  What about remote filesystems of
which you don't know nothing, e. g., a Win7 NTFS?  Did you check the
error codes in this case?

> +
> +  if (pc.isdir ())
> +    status = _unlink_nt_post_dir_check (status, &attr, pc);
> +
> +  if(!check_unlink_status (status))
> +    status = _unlink_ntpc (pc, shareable);
> +
> +  return status;
> +}
> +


Corinna
