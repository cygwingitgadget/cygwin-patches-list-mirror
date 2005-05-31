Return-Path: <cygwin-patches-return-5498-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17862 invoked by alias); 31 May 2005 14:15:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17764 invoked by uid 22791); 31 May 2005 14:15:33 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 31 May 2005 14:15:33 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4954113CA7E; Tue, 31 May 2005 10:15:31 -0400 (EDT)
Date: Tue, 31 May 2005 14:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: link(2) fails on mounted network shares
Message-ID: <20050531141531.GC3750@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <31735.1117548298@www13.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31735.1117548298@www13.gmx.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00094.txt.bz2

On Tue, May 31, 2005 at 04:04:58PM +0200, Martin Koeppe wrote:
>> On Tue, May 31, 2005 at 01:39:04AM +0200, Martin Koeppe wrote:
>> >Hello,
>> >
>> >I recently found out that you cannot create hardlinks
>> >on mounted network shares with cygwin
>> >(error: No such file or directory),
>> >but you can do it with the ln.exe from Interix.
>> >
>> >So I looked at it and found that the Windows API
>> >function CreateHardLink() causes the trouble, it apparently
>> >only works for local drives.
>> >
>> >There is another API function, however, which creates hardlinks
>> >correctly on local and network drives (tested on Win2003 shares
>> >and Samba shares):
>> >
>> >MoveFileEx() with parameter:
>> >#define MOVEFILE_CREATE_HARDLINK 16
>> 
>> I've found two references to this in MSDN.  Both say:
>> 
>> MOVEFILE_CREATE_HARDLINK 	Reserved for future use.
>> 
>> That doesn't sound too encouraging as far as compatibility is concerned.
>
>Ok, but what do you think is better:
>Failing with inappropiate error: "no such file or directory"
>or using a not fully documented API function, but getting the
>link right?
>If you do (with the current cygwin version) on a network drive:
>
>$ ln -s source symdest
>
>works ok, but
>
>$ ln source harddest
>ln: creating hard link `harddest' to `source': No such file or directory
>
>One could consider this as incompatibility, too,
>because the source file is definitely there.
>It would be somewhat better, if it noted, that cygwin doesn't
>support creating hardlinks on network shares, and then copy the file.
>
>But for me, even copying would be bad, as I need the link semantic
>in my case. So copying may be considered incompatible as well.
>
>I did another test: I used MoveFileExA() on Win98 on a
>Win2000 mounted share. But there, instead of a hardlink, an
>ordinary move is done, i.e. source gets deleted.

This is what I mean about compatibility.

If you want to discuss this further, please use the cygwin list.  This
list is for actual patches, not enhancement requests.

cgf
