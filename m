From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: bugs in path_conv::update_fs_info.
Date: Sun, 10 Jun 2001 20:31:00 -0000
Message-id: <20010610233146.E10208@redhat.com>
References: <s1siti8upft.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00282.html

On Fri, Jun 08, 2001 at 03:15:18AM +0900, Kazuhiro Fujieda wrote:
>There are trivial mistakes in path_conv::update_fs_info.
>It can't handle the case where GetCurrentDirectory will fail,
>and invokes GetDriveType with an invalid argument.

Gah!  We're calling GetCurrentDirectory?  I missed that.  What's the
rationale for this?  The previous code didn't have this.  This looks
like YA path_conv slowdown. (These observations are for Egor)

I'd rather just nuke all of this GetCurrentDirectory logic.  I don't
see how it makes sense to use the current directory in this context,
anyway.

cgf

>2001-06-08  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* path.cc (path_conv::update_fs_info): Use cwdstuff instead of
>	GetCurrentDirectory. Set root_dir before invoking GetDriveType.
>
>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.147
>diff -u -p -r1.147 path.cc
>--- path.cc	2001/06/05 10:45:52	1.147
>+++ path.cc	2001/06/07 18:03:24
>@@ -313,8 +313,7 @@ path_conv::update_fs_info (const char* w
>   strncpy (tmp_buf, win32_path, MAX_PATH);
> 
>   if (!rootdir (tmp_buf) &&
>-      (!GetCurrentDirectory (sizeof (tmp_buf), tmp_buf) <= sizeof (tmp_buf) ||
>-       !rootdir (tmp_buf)))       
>+      (!cygheap->cwd.get (tmp_buf, 0) || !rootdir (tmp_buf)))
>     {
>       debug_printf ("Cannot get root component of path %s", win32_path);
>       root_dir [0] = fs_name [0] = '\0';
>@@ -325,13 +324,13 @@ path_conv::update_fs_info (const char* w
> 
>   if (strcmp (tmp_buf, root_dir) != 0)
>     {
>+      strncpy (root_dir, tmp_buf, MAX_PATH);
>       drive_type = GetDriveType (root_dir);
>       if (drive_type == DRIVE_REMOTE || (drive_type == DRIVE_UNKNOWN && (root_dir[0] == '\\' && root_dir[1] == '\\')))
> 	is_remote_drive = 1;
>       else
> 	is_remote_drive = 0;
> 
>-      strncpy (root_dir, tmp_buf, MAX_PATH);
>       if (!GetVolumeInformation (root_dir, NULL, 0, &fs_serial, NULL, &fs_flags,
> 				     fs_name, sizeof (fs_name)))
> 	{
>
>____
>  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>  | HOKURIKU  School of Information Science
>o_/ 1990      Japan Advanced Institute of Science and Technology

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
