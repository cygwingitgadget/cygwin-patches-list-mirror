Return-Path: <cygwin-patches-return-3834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6175 invoked by alias); 28 Apr 2003 20:10:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6166 invoked from network); 28 Apr 2003 20:10:49 -0000
Date: Mon, 28 Apr 2003 20:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: profil fixes
Message-ID: <20030428201135.GA4325@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0304281456300.18331-200000@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0304281456300.18331-200000@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00061.txt.bz2

On Mon, Apr 28, 2003 at 03:07:45PM -0500, Brian Ford wrote:
>2003-04-28  Brian Ford  <ford@vss.fsi.com>
>
>        * profil.h (PROFADDR): Prevent overflow when text segments
>	are larger than 256k.
>	* profil.c (profthr_func): Raise thread priority for more accurate
>	sampling.

Applied.

Thanks,
cgf
