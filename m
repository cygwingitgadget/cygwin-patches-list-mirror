From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Cc: fujieda@jaist.ac.jp
Subject: Re: umount falls into an infinite loop.
Date: Wed, 07 Jun 2000 12:52:00 -0000
Message-id: <20000607154918.I16163@cygnus.com>
References: <s1swvk1r5sr.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00091.html

These look like good changes, but could I impose upon you to improve
the umount (and probably mount) error message handling facility
slightly?

I'd like for the errors to look like unix errors so that we'll
see something like:

umount: couldn't umount '/foo/bar' - No such file or directory

Would you be willing to add some kind of 'error()' function to
these programs which accomplishes this?

cgf

On Wed, Jun 07, 2000 at 10:15:16PM +0900, Kazuhiro Fujieda wrote:
>If there are system mounts and users having no administrative
>privilege run "umount --remove-all-mounts", the umount falls
>into an infinite loop. The following patch can solve this issue.
>
>ChangeLog:
>2000-06-07  Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>
>	* umount.cc (main): Pass the target path instead of "umount" to perror.
>	(remove_all_automounts): Check return status of cygwin_umount and exit.
>	(remove_all_user_mounts): Ditto.
>	(remove_all_system_mounts): Ditto.
>
>Index: umount.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/umount.cc,v
>retrieving revision 1.2
>diff -u -p -r1.2 umount.cc
>--- umount.cc	2000/06/05 18:43:54	1.2
>+++ umount.cc	2000/06/07 12:49:26
>@@ -82,7 +82,7 @@ main (int argc, char **argv)
> 
>   if (cygwin_umount (argv[i], flags) != 0)
>     {
>-      perror ("umount");
>+      perror (argv[i]);
>       exit (1);
>     }
> 
>@@ -109,14 +109,22 @@ remove_all_automounts ()
>       /* Remove the mount if it's an automount. */
>       if (strcmp (p->mnt_type, "user,auto") == 0)
> 	{
>-	  cygwin_umount (p->mnt_dir, 0);
>+	  if (cygwin_umount (p->mnt_dir, 0))
>+	    {
>+	      perror (p->mnt_dir);
>+	      exit (1);
>+	    }
> 	  /* We've modified the table so we need to start over. */
> 	  endmntent (m);
> 	  m = setmntent ("/-not-used-", "r");
> 	}
>       else if (strcmp (p->mnt_type, "system,auto") == 0)
> 	{
>-	  cygwin_umount (p->mnt_dir, MOUNT_SYSTEM);
>+	  if (cygwin_umount (p->mnt_dir, MOUNT_SYSTEM))
>+	    {
>+	      perror (p->mnt_dir);
>+	      exit (1);
>+	    }
> 	  /* We've modified the table so we need to start over. */
> 	  endmntent (m);
> 	  m = setmntent ("/-not-used-", "r");
>@@ -132,14 +140,17 @@ remove_all_user_mounts ()
> {
>   FILE *m = setmntent ("/-not-used-", "r");
>   struct mntent *p;
>-  int err;
> 
>   while ((p = getmntent (m)) != NULL)
>     {
>       /* Remove the mount if it's a user mount. */
>       if (strncmp (p->mnt_type, "user", 4) == 0)
> 	{
>-	  err = cygwin_umount (p->mnt_dir, 0);
>+	  if (cygwin_umount (p->mnt_dir, 0))
>+	    {
>+	      perror (p->mnt_dir);
>+	      exit (1);
>+	    }
> 
> 	  /* We've modified the table so we need to start over. */
> 	  endmntent (m);
>@@ -162,7 +173,11 @@ remove_all_system_mounts ()
>       /* Remove the mount if it's a system mount. */
>       if (strncmp (p->mnt_type, "system", 6) == 0)
> 	{
>-	  cygwin_umount (p->mnt_dir, MOUNT_SYSTEM);
>+	  if (cygwin_umount (p->mnt_dir, MOUNT_SYSTEM))
>+	    {
>+	      perror (p->mnt_dir);
>+	      exit (1);
>+	    }
> 
> 	  /* We've modified the table so we need to start over. */
> 	  endmntent (m);
>
>____
>  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>  | HOKURIKU  School of Information Science
>o_/ 1990      Japan Advanced Institute of Science and Technology

-- 
cgf@cygnus.com                        Cygnus Solutions, a Red Hat company
http://sourceware.cygnus.com/         http://www.redhat.com/
