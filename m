Return-Path: <cygwin-patches-return-5350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11398 invoked by alias); 10 Feb 2005 23:46:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11166 invoked from network); 10 Feb 2005 23:46:12 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 10 Feb 2005 23:46:12 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1CzNyl-0008LO-Et
	for cygwin-patches@cygwin.com; Fri, 11 Feb 2005 00:44:16 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2005 00:44:11 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2005 00:44:11 +0100
To: cygwin-patches@cygwin.com
From: Eric Blake <ebb9@byu.net>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Date: Thu, 10 Feb 2005 23:46:00 -0000
Message-ID: <loom.20050211T000509-58@post.gmane.org>
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de> <loom.20050210T160326-68@post.gmane.org> <20050210155633.GB2597@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.44 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: gocp-cygwin-patches@m.gmane.org
X-MailScanner-To: cygwin-patches@cygwin.com
X-SW-Source: 2005-q1/txt/msg00053.txt.bz2

Corinna Vinschen <vinschen <at> redhat.com> writes:
> Huh?  It reports "NTFS" as filesystem?  Now, *that's* weird.  Especially
> since none of the usual NTFS attributes are set.

I was surprised, too.

> 
> Anyway, can you please test on both drives how they behave if utime
> uses FILE_WRITE_ATTRIBUTES vs. GENERIC_WRITE?

Well, that was my first time ever building cygwin1.dll, but it went smoothly.  
As requested, I tested utimes() when opening with just FILE_WRITE_ATTRIBUTES 
and with full-blown GENERIC_WRITE, on both the ClearCase and the NFS mounted 
drives.  In all four cases, touch(1), which boils down to utimes(2), was able 
to modify all three file times for a file, but returned success without budging 
any of the times on a directory.  Meanwhile, on both the local NTFS partition 
and a shared NTFS drive hosted by another windows machine, utimes(2) correctly 
modified times for both files and directories.

> 
> The expected result would be that the clearcase volume chokes with
> FILE_WRITE_ATTRIBUTES while the Solaris FS should work with it.
> Otherwise we're sort of doomed.

Then we're doomed (but was that ever a surprise from Windows? :)

I also noticed that on remote mounts, all file times are truncated to the 
nearest second when setting or reading (I hope it is truncated, and not 
rounded, because any OS that rounds times risks having timestamps in the 
future, and that causes havoc).  But when I logged in to my Solaris account, 
and accessed the same file systems (the Clearcase and NFS mounts) from there, 
touch was able to use sub-second resolutions, and correctly affected 
directories.  That means that the timestamp truncation is not an inherent 
limitation of NFS or MVFS, but of the Windows implementation that talks to 
those file systems.  I don't know if there is a way to work around Windows not 
touching the times of non-NTFS directories, but that probably isn't as 
important.


$ cd m: # ClearCase mount (MVFS)
$ touch foo
$ stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 1024   regular empty file
Device: 2345789h/36984713d      Inode: 828882696040073479  Links: 1
Access: (0644/-rw-r--r--)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 11:54:43.000000000 -0700
Modify: 2005-02-10 11:54:43.000000000 -0700
Change: 2005-02-10 11:54:43.000000000 -0700
$ touch foo
$ stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 1024   regular empty file
Device: 2345789h/36984713d      Inode: 828882696040073479  Links: 1
Access: (0644/-rw-r--r--)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 11:54:47.000000000 -0700
Modify: 2005-02-10 11:54:47.000000000 -0700
Change: 2005-02-10 11:54:47.000000000 -0700
$ mkdir bar
$ stat bar
  File: `bar'
  Size: 89              Blocks: 1          IO Block: 1024   directory
Device: 2345789h/36984713d      Inode: 828882678826239892  Links: 2
Access: (0755/drwxr-xr-x)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 15:42:32.000000000 -0700
Modify: 2005-02-10 15:42:32.000000000 -0700
Change: 2005-02-10 15:42:32.000000000 -0700
$ touch bar
$ stat bar
  File: `bar'
  Size: 89              Blocks: 1          IO Block: 1024   directory
Device: 2345789h/36984713d      Inode: 828882678826239892  Links: 2
Access: (0755/drwxr-xr-x)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 15:42:32.000000000 -0700
Modify: 2005-02-10 15:42:32.000000000 -0700
Change: 2005-02-10 15:42:32.000000000 -0700

$ cd u: # NFS mount to drive hosted by Solaris, name reported as NTFS
$ touch foo
$ stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 1024   regular empty file
Device: 12da0809h/316278793d    Inode: 2778027755671012815  Links: 1
Access: (0644/-rw-r--r--)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 11:55:31.000000000 -0700
Modify: 2005-02-10 11:55:31.000000000 -0700
Change: 2005-02-10 11:55:31.000000000 -0700
$ touch foo
$ stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 1024   regular empty file
Device: 12da0809h/316278793d    Inode: 2778027755671012815  Links: 1
Access: (0644/-rw-r--r--)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 11:55:34.000000000 -0700
Modify: 2005-02-10 11:55:34.000000000 -0700
Change: 2005-02-10 11:55:34.000000000 -0700
$ mkdir bar
$ stat bar
  File: `bar'
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 12da0809h/316278793d    Inode: 2778027738457179228  Links: 1
Access: (0755/drwxr-xr-x)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 15:40:19.000000000 -0700
Modify: 2005-02-10 15:40:19.000000000 -0700
Change: 2005-02-10 15:40:19.000000000 -0700
$ touch bar
$ stat bar
  File: `bar'
  Size: 0               Blocks: 0          IO Block: 1024   directory
Device: 12da0809h/316278793d    Inode: 2778027738457179228  Links: 1
Access: (0755/drwxr-xr-x)  Uid: (22382/  eblake)   Gid: (10513/Domain Users)
Access: 2005-02-10 15:40:19.000000000 -0700
Modify: 2005-02-10 15:40:19.000000000 -0700
Change: 2005-02-10 15:40:19.000000000 -0700

$ rlogin perth # a Solaris box, where my $HOME is the same as u:\ above
% df -T .
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
hirise:/vol/vol2/home/advtech3
               nfs    83886080  74451144   9434936  89% /home/advtech3
% rm -rf foo bar
% touch foo
% stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 8192   regular empty file
Device: 3e808beh/65538238d      Inode: 4348428     Links: 1
Access: (0664/-rw-rw-r--)  Uid: (  542/  eblake)   Gid: (  542/  eblake)
Access: 2005-02-10 16:12:34.546699000 -0700
Modify: 2005-02-10 16:12:34.546699000 -0700
Change: 2005-02-10 16:12:34.546699000 -0700
% touch foo 
% stat foo
  File: `foo'
  Size: 0               Blocks: 0          IO Block: 8192   regular empty file
Device: 3e808beh/65538238d      Inode: 4348428     Links: 1
Access: (0664/-rw-rw-r--)  Uid: (  542/  eblake)   Gid: (  542/  eblake)
Access: 2005-02-10 16:12:39.652710000 -0700
Modify: 2005-02-10 16:12:39.652710000 -0700
Change: 2005-02-10 16:12:39.652710000 -0700
% mkdir bar
% stat bar
  File: `bar'
  Size: 4096            Blocks: 8          IO Block: 8192   directory
Device: 3e808beh/65538238d      Inode: 4348430     Links: 2
Access: (2775/drwxrwsr-x)  Uid: (  542/  eblake)   Gid: (  542/  eblake)
Access: 2005-02-10 16:12:44.773717000 -0700
Modify: 2005-02-10 16:12:44.773717000 -0700
Change: 2005-02-10 16:12:44.773717000 -0700
% touch bar
% stat bar
  File: `bar'
  Size: 4096            Blocks: 8          IO Block: 8192   directory
Device: 3e808beh/65538238d      Inode: 4348430     Links: 2
Access: (2775/drwxrwsr-x)  Uid: (  542/  eblake)   Gid: (  542/  eblake)
Access: 2005-02-10 16:12:49.289725000 -0700
Modify: 2005-02-10 16:12:49.289725000 -0700
Change: 2005-02-10 16:12:49.289725000 -0700


--
Eric Blake

