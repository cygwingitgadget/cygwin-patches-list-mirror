Return-Path: <cygwin-patches-return-3987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2987 invoked by alias); 2 Jul 2003 14:38:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2967 invoked from network); 2 Jul 2003 14:38:06 -0000
Date: Wed, 02 Jul 2003 14:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: killall utility
Message-ID: <20030702143805.GC11115@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.55.0307021143080.2156@ellixia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.55.0307021143080.2156@ellixia>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00003.txt.bz2

On Wed, Jul 02, 2003 at 11:47:04AM +0100, Elfyn McBratney wrote:
>I have written a killall utility based on the code already in utils/kill.cc .
>Would this make a worthy addition to Cygwin? If so, there's a bit of code
>duplication, so maybe moving the generic code into a file called `sigutil.cc' or
>something would be sufficient, having kill{,all}.exe depending on `sigutil.o'.
>
>Any ideas bofore I submit a patch?

Can't you do something like this with the kill in procps?

cgf
