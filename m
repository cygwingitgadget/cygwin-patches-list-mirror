Return-Path: <cygwin-patches-return-4979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23739 invoked by alias); 22 Sep 2004 15:14:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23727 invoked from network); 22 Sep 2004 15:14:06 -0000
Date: Wed, 22 Sep 2004 15:14:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
Message-ID: <20040922151606.GG26453@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net> <20040922134608.GA26453@trixie.casa.cgf.cx> <41518501.B3406DCF@phumblet.no-ip.org> <20040922140648.GD26453@trixie.casa.cgf.cx> <41518CA5.1EBC4F5@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41518CA5.1EBC4F5@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00131.txt.bz2

On Wed, Sep 22, 2004 at 10:31:01AM -0400, Pierre A. Humblet wrote:
>That particular piece of code is only called when the dir is ".." but
>the parent directory can't be identified, so the result is questionable
>anyway...  I think it can happen when reading a directory like
>'c:some_dir'

Ok.  Thanks for the clarification.  Please check in.

cgf
