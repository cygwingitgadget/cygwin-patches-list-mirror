Return-Path: <cygwin-patches-return-5011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2094 invoked by alias); 5 Oct 2004 07:55:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2083 invoked from network); 5 Oct 2004 07:55:28 -0000
Date: Tue, 05 Oct 2004 07:55:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] has_security
Message-ID: <20041005075633.GH6702@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041004221645.0081f420@incoming.verizon.net> <20041005023112.GA8432@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005023112.GA8432@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00012.txt.bz2

On Oct  4 22:31, Christopher Faylor wrote:
> On Mon, Oct 04, 2004 at 10:16:45PM -0400, Pierre A. Humblet wrote:
> >Another cleanup, following the changes in environ.cc.
> >
> >Pierre
> >
> >2004-10-05  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >	* external.cc (check_ntsec): Do not call wincap.has_security.
> >	* path.cc (path_conv::check): Ditto.
> >	* security.cc (get_object_attribute): Ditto.
> >	(get_file_attribute): Ditto.
> 
> I think this classifies as an obvious fix

Yup.  Please check in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
