Return-Path: <cygwin-patches-return-3329-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17332 invoked by alias); 16 Dec 2002 17:43:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17315 invoked from network); 16 Dec 2002 17:43:22 -0000
Date: Mon, 16 Dec 2002 09:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
Message-ID: <20021216184320.H19104@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFDF1C4.575D6360@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00280.txt.bz2

Hi Pierre,

On Mon, Dec 16, 2002 at 10:31:16AM -0500, Pierre A. Humblet wrote:
> I have a question: there is code in setacl (new line 139) to merge non-default
> ACE's with previous default ACEs.
> As the acl was sorted, I don't see how that code can ever be exercised. 
> Should we try to merge default ACEs with non-default ones? I am not sure it's 
> worth it.

the answer is "yes".

The incoming acls are Sun acls.  They could look like this:

   ...
   user:foo:rw-
   ...
   default:user:foo:rw-

That is a sorted acl, right?  When converting this into a Windows ACL
I'd like to see this as just one ACL, having the correct permissions
*plus* the inheritance attribute.  I don't see how that's incorrect?!?

Corinna
