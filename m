Return-Path: <cygwin-patches-return-4384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22618 invoked by alias); 14 Nov 2003 18:51:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22608 invoked from network); 14 Nov 2003 18:51:08 -0000
Date: Fri, 14 Nov 2003 18:51:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunk createDirectory and createFile calls
Message-ID: <20031114185107.GX18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4A341.5070101@cygwin.com> <20031114155212.GC15938@redhat.com> <1068832095.1109.96.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068832095.1109.96.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00103.txt.bz2

On Sat, Nov 15, 2003 at 04:48:16AM +1100, Robert Collins wrote:
> On Sat, 2003-11-15 at 02:52, Christopher Faylor wrote:
> > On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
> > >        Rename CreateFile to cygwin_create_file throughout.
> >                               ^^^^^^^^^^^^^^^^^^
> > >        Rename CreateDirectory to cygwin_create_directory throughout.
> >                                    ^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > It is a given that we're working in cygwin.  Adding a cygwin_ to the
> > beginning of a function is just noise.
> 
> Heh, will fix... was following Ron's convention semi-blindly.

Well, we have a small problem with get_file_attributes and
set_file_attributes.  We already have two functions called
get_file_attribute and set_file_attribute.  Note that the difference
is only the trailing 's'.

I'd suggest to change the name of the exisiting functions to something
a bit different so that it's less likely to confuse the two calls.
get_file_permissions and set_file_permissions would be good names for
them, wouldn't they?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
