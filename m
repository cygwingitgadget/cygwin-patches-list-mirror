Return-Path: <cygwin-patches-return-4663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19852 invoked by alias); 10 Apr 2004 13:49:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19842 invoked from network); 10 Apr 2004 13:49:19 -0000
Date: Sat, 10 Apr 2004 13:49:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040410134918.GO26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net> <20040410110343.GM26558@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410110343.GM26558@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00015.txt.bz2

On Apr 10 13:03, Corinna Vinschen wrote:
> On Apr  9 23:19, Pierre A. Humblet wrote:
> > Looking to the future, now that fs_info::update isn't really doing an
> > update (a better name would be fs_info::get), it turns out that the
> >   char name_storage[CYG_MAX_PATH];
> >   char root_dir_storage[CYG_MAX_PATH];
> > fields in fs_info can be removed (that requires a few other minor changes). 
> > Doing that would cut down the size of a fhandler from about 920 bytes
> > to 400, which looks like a good thing.
> 
> Yes, you're right.  I'm going to work on this.

I've removed name_storage and root_dir_storage from fs_info.  The only
downside of this should be that statfs now has to call rootdir() by itself.
All fs flags are now centralized in fs_info.  That seems to allow another
slight speed inprovement, even though that's just a few per cent.

> > I am somewhat concerned that the update of fsinfo isn't thread safe.
> > I don't know how the overhead of making it thread safe compares with
> > the overhead of the old method (not caching the fs_info).
> 
> I'll change that soon.

The handling of the global fsinfo array should be thread safe now.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
