Return-Path: <cygwin-patches-return-2242-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 517 invoked by alias); 28 May 2002 14:28:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 497 invoked from network); 28 May 2002 14:28:10 -0000
Message-ID: <20020528142804.31529.qmail@web20006.mail.yahoo.com>
Date: Tue, 28 May 2002 07:28:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: ps help, version patch
To: cygwin-patches@cygwin.com
In-Reply-To: <20020528033821.GA26746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00225.txt.bz2

--- Christopher Faylor <cgf@redhat.com> wrote:
> Good formatting, wrong date == extremely minor problem.
> 
> Applied.
> 
> Thanks.
> 
> cgf

After getting some sleep, I also noticed this line in my usage function:

With options, %s outputs the long format by default\n", prog_name, prog_name);

which should probably read:

With no options, %s outputs the long format by default\n", prog_name,
prog_name);
     ^^

Do I need another patch for this, or can someone just fix YASM (yet another
stupid mistake)?

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
