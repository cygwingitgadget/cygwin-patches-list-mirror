Return-Path: <cygwin-patches-return-5008-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 736 invoked by alias); 5 Oct 2004 02:30:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 724 invoked from network); 5 Oct 2004 02:30:53 -0000
Date: Tue, 05 Oct 2004 02:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] has_security
Message-ID: <20041005023112.GA8432@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041004221645.0081f420@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041004221645.0081f420@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00009.txt.bz2

On Mon, Oct 04, 2004 at 10:16:45PM -0400, Pierre A. Humblet wrote:
>Another cleanup, following the changes in environ.cc.
>
>Pierre
>
>2004-10-05  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* external.cc (check_ntsec): Do not call wincap.has_security.
>	* path.cc (path_conv::check): Ditto.
>	* security.cc (get_object_attribute): Ditto.
>	(get_file_attribute): Ditto.

I think this classifies as an obvious fix but I guess it's only polite
to wait for Corinna to validate that.

cgf
