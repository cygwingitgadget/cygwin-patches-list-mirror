Return-Path: <cygwin-patches-return-1775-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32433 invoked by alias); 24 Jan 2002 19:48:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32374 invoked from network); 24 Jan 2002 19:48:15 -0000
Subject: Re: patch to allow newlib to compile when winsup not present
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: cgf@redhat.com
Cc: newlib@sources.redhat.com, cygwin-patches@cygwin.com
In-Reply-To: <20020124174949.GA3123@redhat.com>
References: <1011834535.1278.46.camel@toggle>
	<02ce01c1a488$156d32b0$0200a8c0@lifelesswks>
	<1011892037.16026.53.camel@toggle>  <20020124174949.GA3123@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Thu, 24 Jan 2002 11:48:00 -0000
Message-Id: <1011901690.1187.55.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q1/txt/msg00132.txt.bz2

On Thu, 2002-01-24 at 12:49, Christopher Faylor wrote:
> On Thu, Jan 24, 2002 at 12:07:15PM -0500, Thomas Fitzsimmons wrote:
> >On Wed, 2002-01-23 at 22:34, Robert Collins wrote:
> >> 
> >> ===
> >> ----- Original Message -----
> >> From: "Thomas Fitzsimmons" <fitzsim@redhat.com>
> >> To: <cygwin-patches@cygwin.com>
> >> Cc: <newlib@sources.redhat.com>
> >> Sent: Thursday, January 24, 2002 12:08 PM
> >> Subject: patch to allow newlib to compile when winsup not present
> >> 
> >> 
> >> > I've applied this patch to newlib, so that it will compile for the
> >> > i686-pc-cygwin target, when winsup is not in the source tree.
> >> > Previously, the newlib build failed because pthread_t was undefined.
> >> 
> >> This is incorrect. Cygwin has pthread_kill, so you _will need_ the
> >> cygwin header files to compile newlib for i686-pc-cygwin, regardless of
> >> having winsup in the source tree or not.
> >> 
> >
> >Then would a better solution be to include
> >winsup/cygwin/include/cygwin/types.h in the newlib distribution?
> 
> What's wrong with saying that you need the winsup directory or a cygwin
> installation to compile the cygwin versions of newlib?
> 

That is a possibility, but even in that case, the build shouldn't fail
with an obscure undefined symbol error at compile time.  If we're going
to require either the winsup directory, or a cygwin installation, there
should be checks for these at configuration time. However, usually,
newlib doesn't handle header dependencies in this way.

newlib typically includes system-specific headers (like types.h) in the
newlib distribution (like in newlib/libc/sys/cygwin/include).  Is there
any reason why this can't be done for the cygwin target?

Tom

-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9
