Return-Path: <cygwin-patches-return-4359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11017 invoked by alias); 12 Nov 2003 09:27:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11005 invoked from network); 12 Nov 2003 09:27:01 -0000
Date: Wed, 12 Nov 2003 09:27:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc typo
Message-ID: <20031112092700.GA7542@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311111612280.9584@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00078.txt.bz2

On Tue, Nov 11, 2003 at 06:08:08PM -0600, Brian Ford wrote:
> I don't know c++ much/at all, but this looks wrong to me.  I don't
> understand how it even compiled before?  Feel free to slap me in the face
> because you can switch on a struct in c++? :)

See devices.h, definition of "operator int()" ;-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
