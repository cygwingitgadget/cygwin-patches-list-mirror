Return-Path: <cygwin-patches-return-5251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3059 invoked by alias); 18 Dec 2004 22:09:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3029 invoked from network); 18 Dec 2004 22:09:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Dec 2004 22:09:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id D4B4D1B401; Sat, 18 Dec 2004 17:10:57 -0500 (EST)
Date: Sat, 18 Dec 2004 22:09:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041218221057.GB11307@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx> <20041218172053.GA9932@trixie.casa.cgf.cx> <41C476F1.6060700@x-ray.at> <41C49377.57107AA9@dessent.net> <Pine.GSO.4.61.0412181645420.2298@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0412181645420.2298@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00252.txt.bz2

On Sat, Dec 18, 2004 at 04:48:50PM -0500, Igor Pechtchanski wrote:
>There are two possible interpretations here.  One is that Reini is
>proposing to have Cygwin tools always list alternate streams, in which
>case you're correct, and it's unrelated to the thread.  Another is that
>colons in filenames on certain Cygwin mounts should not represent
>alternate streams, but should be different files altogether, and thus
>should be listed normally.
>
>That said, I think Reini's wording implies your interpretation, and thus
>his suggestion should be in a different thread.

There really isn't much that we can do with colons, AFAICT.  We
certainly can't disallow them in the common case and I don't think there
is any FindFirstFile/FindNextFile type API which allows us to easily
expose them.

Although I can see that it would be nice to have a unifying philosophy here
I think the strange behavior of a foo:bar on an NTFS file system is not
something that we should worry about right now.

cgf
