Return-Path: <cygwin-patches-return-3246-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11699 invoked by alias); 29 Nov 2002 18:16:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11687 invoked from network); 29 Nov 2002 18:16:19 -0000
Message-Id: <3.0.5.32.20021129131613.0083fc70@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Fri, 29 Nov 2002 10:16:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Internal get{pw,gr}XX calls
In-Reply-To: <3.0.5.32.20021129131134.00835870@mail.attbi.com>
References: <20021129184501.E1398@cygbert.vinschen.de>
 <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021126000911.00833190@mail.attbi.com>
 <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00197.txt.bz2

At 01:11 PM 11/29/2002 -0500, Pierre A. Humblet wrote:
>But, now that I am staring at it, we will have problems with 32 bit
>uids > 0x8000000, except if they are entered as negative numbers.
>This is from the opengroup:
>If the correct value is outside the range of representable values, 
>LONG_MAX or LONG_MIN is returned (according to the sign of the value),
>and errno is set to [ERANGE]. 
>
One way out is to use strtoll and return the 32 low bits. That will
work with uid values entered as positive or negative numbers.

Pierre

