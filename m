Return-Path: <cygwin-patches-return-4661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21794 invoked by alias); 10 Apr 2004 09:25:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21779 invoked from network); 10 Apr 2004 09:25:03 -0000
Date: Sat, 10 Apr 2004 09:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040410092502.GA11345@coe>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 10 Apr 2004 09:23:57.0401 (UTC) FILETIME=[8CEAA490:01C41EDD]
X-SW-Source: 2004-q2/txt/msg00013.txt.bz2

On Fri, Apr 09, 2004 at 11:19:57PM -0400, Pierre A. Humblet wrote:
>I am somewhat concerned that the update of fsinfo isn't thread safe.
>I don't know how the overhead of making it thread safe compares with
>the overhead of the old method (not caching the fs_info).

Corinna, this is a problem that I didn't consider on reviewing your patch.

Could you look into making this thread safe?

cgf
