Return-Path: <cygwin-patches-return-4184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32626 invoked by alias); 9 Sep 2003 01:11:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32617 invoked from network); 9 Sep 2003 01:11:34 -0000
Date: Tue, 09 Sep 2003 01:11:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in mount table.
Message-ID: <20030909011134.GA6708@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030908204606.00816d10@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030908204606.00816d10@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00200.txt.bz2

On Mon, Sep 08, 2003 at 08:46:06PM -0400, Pierre A. Humblet wrote:
>This is the first in a series of patches fixing security holes
>associated with the file mappings in the core of Cygwin.
>I hope the explanations below are clear!

Yes they are, thanks.  I can't comment on the security stuff but
everything else looks good to me.  I'll let Corinna have the final
say on this.

I wonder if it is time to bite the bullet and get rid of user-mode
mounts entirely.  Or maybe disallow them in suid'ed sessions?  They
are always going to be a security hole AFAICT.

cgf
