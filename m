Return-Path: <cygwin-patches-return-4583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7081 invoked by alias); 3 Mar 2004 09:53:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7072 invoked from network); 3 Mar 2004 09:53:48 -0000
Date: Wed, 03 Mar 2004 09:53:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: munmap slowness; IsBadReadPtr considered harmful
Message-ID: <20040303095350.GB1587@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0402201138400.25876@thing1-200> <Pine.GSO.4.58.0402231502330.6954@thing1-200> <20040224165708.GS1587@cygbert.vinschen.de> <Pine.GSO.4.58.0402241658050.14041@thing1-200> <20040225105505.GV1587@cygbert.vinschen.de> <Pine.GSO.4.58.0402251335320.24531@thing1-200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402251335320.24531@thing1-200>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00073.txt.bz2

[Sorry for the delay, I didn't realize that my mail to cygwin-patches
 didn't come through]

On Feb 25 14:04, Brian Ford wrote:
>         * miscfuncs.cc (check_invalid_virtual_addr): Assure the last page
> 	in the range is always tested.  Add appropriate const.
> 
> 	* mmap.cc (mmap_record::aloc_fh): Remove unused static path_conf
> 	object.

Both applied.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
