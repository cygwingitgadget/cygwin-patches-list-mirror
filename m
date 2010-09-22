Return-Path: <cygwin-patches-return-7113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27579 invoked by alias); 22 Sep 2010 09:32:33 -0000
Received: (qmail 27521 invoked by uid 22791); 22 Sep 2010 09:32:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 22 Sep 2010 09:32:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 33E126D4397; Wed, 22 Sep 2010 11:32:08 +0200 (CEST)
Date: Wed, 22 Sep 2010 09:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100922093208.GF13235@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com> <20100912114115.GA1113@calimero.vinschen.de> <4C8E0AC7.9080409@gmail.com> <20100914100533.GC15121@calimero.vinschen.de> <4C99980F.5010202@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <4C99980F.5010202@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00073.txt.bz2


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-length: 6472

On Sep 22 07:45, Yoni Londner wrote:
> Hi,
> 
> > There's also the problem of handling NFS shares.  However, I just had an
> > idea how to speed up symlink_info::check without neglecting NFS shares.
> > This will take some time, though since it turns a lot of code upside
> > down.  Stay tuned.
> 
> This sounds great! Cygwin filesystem performance is a very important
> issue, and any improvement is more than welcome!

Unfortunately it didn't work out the way I anticipated.  See below.

> > I don't understand how you think this should work.  The filter expression
> > given to NtQueryDirectoryFile is either a constant string and has
> to match
> > the filename exactly, or it contains wildcards.  This is documented
> > behaviour:
> http://msdn.microsoft.com/en-us/library/ff567047%28VS.85%29.aspx
> > So, "foo" works, "foo*" works, but a list like "foo foo.exe foo.lnk"
> > does not.
> 
> There are two options for stat() and other places the need file info
> (such as check_symlink):
> 
> 1) CreateFile(the_dir), then NtQueryDirectoryFile("foo*") and
> retrieve all the info (including the hardlink), filter out the

How are you going to do that?  Pray tell me the NtQueryDirectoryFile
info class which returns the number of hardlinks to a file.  To the
best of my knowledge there is none.

Then there are the FileIdBothDirectoryInformation and
FileIdFullDirectoryInformation info classes, which were a nice idea, but
they have a downside, as you can see in fhandler_disk_file::readdir.
First, it doesn't exist on pre-XP systems.  Second, there are a couple
of filesystems out in the wild which don't support the call.  Third,
worse, there are filesystems which implement the call wrongly.  Forth,
there's MSFT NFS which does not return dangling symlinks in calls to
NtQueryDirectoryFile, unless the info class is FileNamesInformation.
Last but not least, hardlink count and permissions are still missing.
So, using FileIdBothDirectoryInformation is far from being a swiss army
knife.

> results in user-mode ("foo", "foo.exe", "foo.lnk"), and then call
> CloseHandle().
> 
> 2) CreateFile(the_dir), NtQueryDirectoryFile("foo"),
> NtQueryDirectoryFile("foo.exe"), NtQueryDirectoryFile("foo.lnk"),
> CloseHandle(). The calls to NtQueryDirectoryFile() should be with
> RestartScan=1, so that the the_dir handle can be reused. Also
> ReturnSingleEntry=1 can be set to improve performance.

That was the method I tried.  It doesn't work.  This is documented
in the aforementioned link to the NtQueryDirectoryFile man page:

 "The FileName is used as a search expression and is captured
  on the very first call to ZwQueryDirectoryFile for a given handle.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Subsequent calls to ZwQueryDirectoryFile will use the search expression
  set in the first call.
  The FileName parameter passed to subsequent calls will be ignored."
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can't use RestartScan in conjunction with another filter expression
to restart the scan with another filter expression.  Either you are
lucky and the filename exists without .exe or .lnk suffix so that it's
returned by the first call, or what you get is the status code
STATUS_NO_MORE_FILES in any subsequent call with changed filter
expression.  So, if you use this method you would have to close and
reopen the directory handle for every iteration on the suffix.  Which in
turn slows down the method enormously.  The end result was slower than
the current implementation.

When I have time I will try the #1 solution as well, but it requires
some more changes in symlink_info and needs more time, so it's kind of
on the backburner for now.  I can see how general file access can
profit from a faster symlink_info::check which does not open every
file, but that won't affect stat() in the first place, rather other
calls which don't need stat-like info.

> This is instead what is done today in cygwin:
> 3) CreateFile("foo"), NtQueryFileInformation(), CloseHandle() (and
> repeat this for "foo.exe" and "foo.lnk")

Well, it's more like

  Repeat CreateFile("foo${SUFFIX}") until file is found, then call
  NtQueryFileInformation(), CloseHandle() exactly once.

> I did some performance tests comparing #1 #2 and #3.
> 
> I found out that #1 and #2 are both around 10x to 100x (!!!) times
> faster than #3.

I guess so, but you can also get such figures by just using `ls',
not `ls -l'.  But afaics you're comparing apples with oranges
since you deliberately drop information.  Where is the hardlink
count?  Where are the POSIX permissions?

> I checked out why, and found out that #1 and #2 don't modify the
> access time of the file, whereas #3 does. This already immediately

I just checked this and I can't see that it does.  If it would do
so, shouldn't the access time be different every time I call stat?

  $ stat foo | grep 'Access: [0-9]'
  Access: 2010-09-09 16:27:20.769055700 +0200
  $ stat foo | grep 'Access: [0-9]'
  Access: 2010-09-09 16:27:20.769055700 +0200
  $ stat foo | grep 'Access: [0-9]'
  Access: 2010-09-09 16:27:20.769055700 +0200

I tried it on Windows XP SP3 and Windows 7.

> [...]
> I would suggest using #2 over #1, since its simpler code-wise, and I
> did not see any serious performance difference between the two.

Ok, how is the performance comparison if stat returns the *correct*
hardlink count and the *correct* POSIX permissions?

And how did you get #2 working?  I tried it on XP and W7, but the result
is exactly as I described above.  It just doesn't work to exchange the
filter expression and set RestartScan to TRUE.  I attached a simple
testcase to show what I did.  Here's what happens.  Note that there is
only a file w32-pwd.exe in my homedir, no w32-pwd or w32-pwd.lnk.

  $ gcc -g -o ntquerydir ntquerydir.c -lntdll
  $ ./ntquerydir C:\\cygwin\\home\\corinna w32-pwd
  Filter: w32-pwd
    NtQueryDirectoryFile: 0xc000000f
  Filter: w32-pwd.exe
    NtQueryDirectoryFile: 0x80000006
  Filter: w32-pwd.lnk
    NtQueryDirectoryFile: 0x80000006
  $ ./ntquerydir C:\\cygwin\\home\\corinna w32-pwd.exe
  Filter: w32-pwd.exe
    w32-pwd.exe
  Filter: w32-pwd.exe.exe
    w32-pwd.exe
  Filter: w32-pwd.exe.lnk
    w32-pwd.exe

As you can see, the RestartScan==TRUE does not replace the filter
expression.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

--W/nzBZO5zC0uMSeA
Content-Type: text/x-c++src; charset=utf-8
Content-Disposition: attachment; filename="ntquerydir.c"
Content-length: 2163

#define WINVER 0x0601
#include <windows.h>
#include <ddk/ntifs.h>
#include <ddk/winddk.h>
#include <stdio.h>
#include <wchar.h>
#include <locale.h>
#include <limits.h>

int
main (int argc, char **argv)
{
  BYTE buffer[sizeof (FILE_ID_BOTH_DIRECTORY_INFORMATION)
	      + (NAME_MAX + 1) * sizeof (WCHAR)];
  WCHAR dirpath[MAX_PATH];
  WCHAR filterbuf[NAME_MAX + 1];
  UNICODE_STRING dirname;
  UNICODE_STRING filter;
  OBJECT_ATTRIBUTES attr;
  NTSTATUS status;
  HANDLE dir;
  IO_STATUS_BLOCK io;
  int num;
  USHORT filterlen;

  if (argc < 3)
    return 0;

  setlocale (LC_ALL, "");
  wcscpy (dirpath, L"\\??\\");
  if (!strncmp (argv[1], "\\\\", 2))
    {
      wcscat (dirpath, L"UNC");
      ++argv[1];
    }
  mbstowcs (dirpath + wcslen (dirpath), argv[1], 256 - wcslen (dirpath));
  RtlInitUnicodeString (&dirname, dirpath);

  mbstowcs (filterbuf, argv[2], 256);
  RtlInitUnicodeString (&filter, filterbuf);
  filterlen = filter.Length / sizeof (WCHAR);

  InitializeObjectAttributes (&attr, &dirname, 0, 0, 0);
  status = NtOpenFile (&dir, FILE_LIST_DIRECTORY | SYNCHRONIZE,
		       &attr, &io, FILE_SHARE_VALID_FLAGS,
		       FILE_SYNCHRONOUS_IO_NONALERT
		       | FILE_OPEN_FOR_BACKUP_INTENT
		       | FILE_DIRECTORY_FILE);
  if (!NT_SUCCESS (status))
    {
      printf ("  NtOpenFile: %p\n", status);
      return 1;
    }
  for (num = 0; num < 3; ++num)
    {
      printf ("Filter: %ls\n", filter.Buffer);
      status = NtQueryDirectoryFile (dir, NULL, NULL, NULL, &io,
				     buffer, sizeof buffer,
				     FileIdBothDirectoryInformation, TRUE,
				     filter.Length ? &filter : NULL, TRUE);
      if (!NT_SUCCESS (status))
	printf ("  NtQueryDirectoryFile: %p\n", status);
      else
      	{
	  FILE_POSITION_INFORMATION fpi;
	  PFILE_ID_BOTH_DIRECTORY_INFORMATION fdi
	    = (PFILE_ID_BOTH_DIRECTORY_INFORMATION) buffer;
	  printf ("  %.*ls\n", fdi->FileNameLength / sizeof (WCHAR),
			       fdi->FileName);
	}
      if (num == 0)
	{
	  wcscpy (filter.Buffer + filterlen, L".exe");
	  filter.Length += 4 * sizeof (WCHAR);
	}
      else if (num == 1)
	wcscpy (filter.Buffer + filterlen, L".lnk");
    }
  NtClose (dir);
  return 0;
}

--W/nzBZO5zC0uMSeA--
