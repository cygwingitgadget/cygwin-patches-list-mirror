Return-Path: <cygwin-patches-return-2134-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18619 invoked by alias); 2 May 2002 04:15:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18590 invoked from network); 2 May 2002 04:15:30 -0000
Date: Wed, 01 May 2002 21:15:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc and /proc/registry
Message-ID: <20020502041533.GA31258@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <006401c1b998$c106f230$0100a8c0@advent02> <20020219230649.GC4626@redhat.com> <024601c1b9a3$2f8fb700$0100a8c0@advent02> <20020220003104.GD22591@redhat.com> <20020225164230.GA17325@redhat.com> <001301c1be40$647220b0$0100a8c0@advent02> <20020225214630.GD22795@redhat.com> <00b501c1bec2$ae997530$0100a8c0@advent02> <20020227170138.GA2380@redhat.com> <00de01c1bfea$85045270$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00de01c1bfea$85045270$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00118.txt.bz2

On Wed, Feb 27, 2002 at 11:57:30PM -0000, Chris January wrote:
>> On Tue, Feb 26, 2002 at 12:39:47PM -0000, Chris January wrote:
>> >> 1) The copyrights still need to be changed.
>> >Done.
>> >> 2) The code formatting still is not correct.
>> >Now piped through indent with a few touch-ups.
>> >> 3) You have a lot of calls to normalize_posix_path.  Is that really
>> >>    necessary?  It seems to be called a lot.  If it is really necessary,
>> >>    I'd prefer that it just be called in dtable::build_fhandler and made
>> >>    the standard "unix_path_name".
>> >Done.
>> >> 4) Could you generate the diff using 'cvs diff -up"
>> >Done. The new files are diff'ed against /dev/null and are appended to the
>> >output of cvs diff.
>
><--snip-->
>
>> Phew.
>
>Please find attached another patch with modifications as per your comments.
>I don't have much time to work on this anymore so this will have to be the
>last patch. ChangeLog is as before.

Despite my trepidations about committing something where the submitter
says he has no more time, I've committed this patch.

It was just too cool to be able to do 'ls /proc/registry'.

Thanks,
cgf
