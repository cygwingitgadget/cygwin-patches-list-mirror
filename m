Return-Path: <cygwin-patches-return-3649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18872 invoked by alias); 28 Feb 2003 06:03:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18855 invoked from network); 28 Feb 2003 06:03:53 -0000
Message-Id: <3.0.5.32.20030228010258.007f2870@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Fri, 28 Feb 2003 06:03:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: access () and path.cc
In-Reply-To: <20030228055635.GB24690@redhat.com>
References: <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net>
 <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
 <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
 <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
 <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
 <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00298.txt.bz2

At 12:56 AM 2/28/2003 -0500, you wrote:
>On Fri, Feb 28, 2003 at 12:49:59AM -0500, Pierre A. Humblet wrote:
>>OK, following Chris' remarks here is a much smaller set
>>of changes.
>
>Do you think it would make sense to do something along the lines
>of:
>>+      path_conv pc (cfd->is_device ? cfd->get_name () :
cfd->get_win32_name (), PC_SYM_NOFOLLOW);

I guess one could but judging from the times I see in 
strace it's not really justified.

On the other hand that's something that we could look 
at after you integrate your code. There could eventually
be a single get_name returning what's appropriate.

Pierre
