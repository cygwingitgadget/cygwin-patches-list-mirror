From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 16:17:00 -0000
Message-id: <20010510191539.A20530@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102247.SAA25227@envy.delorie.com>
X-SW-Source: 2001-q2/msg00234.html

On Thu, May 10, 2001 at 06:47:48PM -0400, DJ Delorie wrote:
>I don't think setup needs to know the difference between a new install
>and an upgrade, just some simple common-sense rules about the mount
>table:
>
>* Create the / mount.  This always happens, because we ask the user for
>it.
>
>* For other mount points setup wants to create, check to see if the
>directory is non-empty.  If so, warn the user.  I'm not sure if setup
>can gracefully deal with a non-empty directory without a lot of extra
>logic.  I'm also not sure what to do with existing mounts that refer to
>subdirectories of the old root mount (if old root differs from new
>root).  It's probably a bad idea to keep them around, since you'd end
>up either mixing versions or corrupting the old installation, but
>should we delete them or map them into the new root?
>
>* Now, read the *whole* mount table as it now stands.
>
>* When creating files (either for its own purposes or while extracting
>a tar file), honor the mount table as-is.

This is close to what I have done.  I'm almost finished with something
that uses the mount table.

cgf
