Return-Path: <cygwin-patches-return-5016-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12022 invoked by alias); 5 Oct 2004 14:45:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11837 invoked from network); 5 Oct 2004 14:45:44 -0000
Date: Tue, 05 Oct 2004 14:45:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041005144649.GB30752@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005143458.GB13719@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00017.txt.bz2

On Oct  5 10:34, Christopher Faylor wrote:
> On Tue, Oct 05, 2004 at 09:09:31AM -0500, Brian Ford wrote:
> >The current directory is specified by a null path name, which can appear
> >immediately after the equal sign, between two colon delimiters anywhere in
> >the path list, or at the end of the path list.
> >[...]
> >I believe this is a valid construct and I have used it frequently.
> 
> Ditto.
> 
> PATH=/foo::/bar
> 
> means search for /foo, then the current directory, then /bar.

Oh, interesting.  I never even thought about using an empty path.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
