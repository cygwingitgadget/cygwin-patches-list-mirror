From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 16:21:00 -0000
Message-id: <VA.00000767.0059a04d@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102247.SAA25227@envy.delorie.com>
X-SW-Source: 2001-q2/msg00235.html

DJ Delorie wrote:
> * For other mount points setup wants to create, check to see if the
>   directory is non-empty.  If so, warn the user.  I'm not sure if
>   setup can gracefully deal with a non-empty directory without a lot
>   of extra logic.  I'm also not sure what to do with existing mounts
>   that refer to subdirectories of the old root mount (if old root
>   differs from new root).  It's probably a bad idea to keep them
>   around, since you'd end up either mixing versions or corrupting the
>   old installation, but should we delete them or map them into the new
>   root?
>
I agree with all but this one.  I really thought that all that was needed 
would be to use the mount table and if setup plans to install in 
{root_dir}/usr/bin then we look for a mount point referencing /usr/bin 
and if that points to e:\bin then that is where setup installs the files. 
Essentially a reverse lookup and assume that if the user moved the files 
from {root_dir}/usr/bin to e:\bin when the root_dir was d:\cygwin then 
the operator knew what he/she was doing and was thorough and complete 
doing it.  If they weren't thorough or careful and thus have a /usr/bin 
with files already in it but they have already covered it with their 
e:\bin then setup still did it right.  Bear in mind this is sort of what 
I meant by an update versus new install.

