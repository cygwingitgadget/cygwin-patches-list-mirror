Return-Path: <cygwin-patches-return-2998-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3818 invoked by alias); 19 Sep 2002 03:33:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3802 invoked from network); 19 Sep 2002 03:33:47 -0000
Date: Wed, 18 Sep 2002 20:33:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More changes about open on Win95 directories.
Message-ID: <20020919033417.GA15825@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020918220225.00810100@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00446.txt.bz2

On Wed, Sep 18, 2002 at 10:02:25PM -0400, Pierre A. Humblet wrote:
>I fixed all that by adding set_nohandle () and get_nohandle () appropriately.
>To avoid submitting patches on top of yesterday changes, I include cumulative 
>changes for the last two days.
>
>Also, on line 476 of fhandler_disk_file.cc, in lock,  I see
>  if (fl->l_len < 0)
>    {
>      win32_start -= fl->l_len;
>      win32_len = -fl->l_len;
>    }
>It seems to me that we want to decrement win32_start, which would mean
>we should add the negative fl->l_len, or am I confused?

I've looked at that code a few times and wondered about that.  It seems
backwards but maybe someone else has more insight.

>And yesterday's question: On line 173 of fhandler_disk_file.cc 
>[strpbrk (get_win32_name (), "?*|<>|")] is there a need for the 
>two '|'? Was something else meant?

I removed it.  I don't know if there is another invalid character that
should go there or not, though.

I've checked in the rest of your patch with some minor formatting fixes
to the ChangeLog and code.

FYI, it is not GNU standard to do:

  if (foo) bar = 1;

It should be

  if (foo)
    bar = 1;

Anyway, thanks for the patch.  It looks really useful.

cgf
