Return-Path: <cygwin-patches-return-1903-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12903 invoked by alias); 25 Feb 2002 21:46:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12855 invoked from network); 25 Feb 2002 21:46:18 -0000
Date: Mon, 25 Feb 2002 13:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc and /proc/registry
Message-ID: <20020225214630.GD22795@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <008901c1b1be$80b36e70$0100a8c0@advent02> <20020210043745.GA5128@redhat.com> <006401c1b998$c106f230$0100a8c0@advent02> <20020219230649.GC4626@redhat.com> <024601c1b9a3$2f8fb700$0100a8c0@advent02> <20020220003104.GD22591@redhat.com> <20020225164230.GA17325@redhat.com> <001301c1be40$647220b0$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c1be40$647220b0$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00260.txt.bz2

On Mon, Feb 25, 2002 at 09:07:10PM -0000, Chris January wrote:
>> Please resubmit your patch against current CVS sources.
>Please find patch against today's CVS attached.

Ok.  Preliminary comments.

1) The copyrights still need to be changed.

2) The code formatting still is not correct.

3) You have a lot of calls to normalize_posix_path.  Is that really
   necessary?  It seems to be called a lot.  If it is really necessary,
   I'd prefer that it just be called in dtable::build_fhandler and made
   the standard "unix_path_name".

4) Could you generate the diff using 'cvs diff -up"

I haven't applied the patch to test it yet.  Anyone else interested in
doing this?

cgf
