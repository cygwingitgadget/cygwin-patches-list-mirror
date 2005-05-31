Return-Path: <cygwin-patches-return-5497-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1104 invoked by alias); 31 May 2005 14:05:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32702 invoked by uid 22791); 31 May 2005 14:05:01 -0000
Received: from pop.gmx.de (HELO mail.gmx.net) (213.165.64.20)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Tue, 31 May 2005 14:05:01 +0000
Received: (qmail 5322 invoked by uid 0); 31 May 2005 14:04:58 -0000
Received: from 84.178.78.174 by www13.gmx.net with HTTP;
	Tue, 31 May 2005 16:04:58 +0200 (MEST)
Date: Tue, 31 May 2005 14:05:00 -0000
From: "Martin Koeppe" <mkoeppe@gmx.de>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Subject: Re: link(2) fails on mounted network shares
X-Authenticated: #449785
Message-ID: <31735.1117548298@www13.gmx.net>
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00093.txt.bz2

> On Tue, May 31, 2005 at 01:39:04AM +0200, Martin Koeppe wrote:
> >Hello,
> >
> >I recently found out that you cannot create hardlinks
> >on mounted network shares with cygwin
> >(error: No such file or directory),
> >but you can do it with the ln.exe from Interix.
> >
> >So I looked at it and found that the Windows API
> >function CreateHardLink() causes the trouble, it apparently
> >only works for local drives.
> >
> >There is another API function, however, which creates hardlinks
> >correctly on local and network drives (tested on Win2003 shares
> >and Samba shares):
> >
> >MoveFileEx() with parameter:
> >#define MOVEFILE_CREATE_HARDLINK 16
> 
> I've found two references to this in MSDN.  Both say:
> 
> MOVEFILE_CREATE_HARDLINK 	Reserved for future use.
> 
> That doesn't sound too encouraging as far as compatibility is concerned.

Ok, but what do you think is better:
Failing with inappropiate error: "no such file or directory"
or using a not fully documented API function, but getting the
link right?
If you do (with the current cygwin version) on a network drive:

$ ln -s source symdest

works ok, but

$ ln source harddest
ln: creating hard link `harddest' to `source': No such file or directory

One could consider this as incompatibility, too,
because the source file is definitely there.
It would be somewhat better, if it noted, that cygwin doesn't
support creating hardlinks on network shares, and then copy the file.

But for me, even copying would be bad, as I need the link semantic
in my case. So copying may be considered incompatible as well.

I did another test: I used MoveFileExA() on Win98 on a
Win2000 mounted share. But there, instead of a hardlink, an
ordinary move is done, i.e. source gets deleted.

Then I made a third test: A Win98 share mounted on Win2K:
With cygwin's ln (i.e. CreateHardLink()) I get
"no such file or diectory", whereas with MoveFileEx()
I get ERROR_UNEXP_NET_ERR (59), which Interix translates to
"Network is down".

Both error conditions are not meaningful,
but at least MoveFileEx() doesn't do unexpected actions,
but aborts with error code.

When the cygwin workaround of copying the file is concerned,
it should be done in this case, as the real situation is:
hardlink not supported.

Or maybe, when running on >=Win2K, the copy workaround
should be completely disabled. Would probably mean, that
cygwin must be installed on a NTFS drive with these OSes
(because the "cygwin OS" may rely on having hardlinks
available), but does that matter nowadays?

If you don't like to completely replace CreateHardLink(),
one maybe could do something like this:

BOOL ok = false;
DWORD err;

if (this OS is Win2K/XP/2K3) {
  ok = CreateHardLink();
  err = GetLastError();
  if (err == ERROR_INVALID_NAME /* 123 */) {
    // retry with MoveFileEx()
    ok = MoveFileEx();
    err = GetLastError();
  }
}

if (! ok) {
  // do workaround or error handling
}

I tested MoveFileEx() successfully on Win2K, Win2K3 (both server and client)
and Samba3 (only as server).


Martin
