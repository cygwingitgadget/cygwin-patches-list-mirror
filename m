Return-Path: <cygwin-patches-return-3020-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20989 invoked by alias); 22 Sep 2002 03:21:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20941 invoked from network); 22 Sep 2002 03:21:47 -0000
Message-Id: <3.0.5.32.20020921231219.00833600@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Sat, 21 Sep 2002 20:21:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Cleaning up for NULL handles
In-Reply-To: <20020922015828.GA6730@redhat.com>
References: <3.0.5.32.20020920192828.0080c640@mail.attbi.com>
 <3.0.5.32.20020920192828.0080c640@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00468.txt.bz2

At 09:58 PM 9/21/2002 -0400, Christopher Faylor wrote:
>So, although the fact that CreateFile will return INVALID_HANDLE_VALUE
>on error is documented, I think we can safely assume that CreateFile
>will never return a NULL handle either.

Fair enough. I would still recommend to apply the patch because it 
guarantees that invalid io_handles have the same value (0 or -1, depending
on handlers) in a parent and a dup'ed child, avoiding a source of bugs.
It doesn't add any new lines, only deleting two useless ones.

The matter of locks with negative lengths was left unresolved, around
line 475 in fhandler_disk_file.cc
According to

http://www.opengroup.org/onlinepubs/007908799/xsh/fcntl.html

"If l_len is positive, the area affected starts at l_start and ends at 
l_start + l_len-1. If l_len is negative, the area affected starts at 
l_start + l_len and ends at l_start-1. Locks may start and extend beyond 
the current end of a file, but must not be negative relative to the 
beginning of the file. A lock will be set to extend to the largest 
possible value of the file offset for that file by setting l_len to 0."

So there should be a += in the third line below.
  if (fl->l_len < 0)
    {
      win32_start -= fl->l_len;
      win32_len = -fl->l_len;
    } 
In addition the sentence about not being negative relative to the beginning
of a file implies (please verify this) that the condition win32_start < 0
below should always result in EINVAL. There is no need to subtract the negative
of a negative number to try to fix things up :)
  if (win32_start < 0)
    {
      /* watch the signs! */
      win32_len -= -win32_start;
      if (win32_len <= 0)
	{
	  /* Failure ! */
	  set_errno (EINVAL);
	  return -1;
	}
      win32_start = 0;
    }
If you agree I will send a patch. You may also decide that it's faster 
overall for you to edit the file directly.

Pierre
