Return-Path: <cygwin-patches-return-3506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27553 invoked by alias); 5 Feb 2003 17:13:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27525 invoked from network); 5 Feb 2003 17:13:19 -0000
Date: Wed, 05 Feb 2003 17:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sec_acl.cc
Message-ID: <20030205171317.GZ5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030205163738.GW5822@cygbert.vinschen.de> <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20030205091505.007fc270@mail.attbi.com> <3.0.5.32.20030205091505.007fc270@mail.attbi.com> <3.0.5.32.20030205102239.00805100@h00207811519c.ne.client2.attbi.com> <3.0.5.32.20030205112940.00804ab0@h00207811519c.ne.client2.attbi.com> <20030205163738.GW5822@cygbert.vinschen.de> <3.0.5.32.20030205120201.007ef6c0@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030205120201.007ef6c0@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00155.txt.bz2

On Wed, Feb 05, 2003 at 12:02:01PM -0500, Pierre A. Humblet wrote:
> At 05:45 PM 2/5/2003 +0100, Corinna Vinschen wrote:
> >But still, it's more correct, isn't it.
> That's opinion, not fact! It's also relatively convoluted code that does
> little, or perhaps even nothing! 

No problem, then it's my opinion that it's more correct.

> How was the DELETE_FILE (or whatever the name) permission on the directory?
> I tried here and got an error message.

When DELETE_CHILD is off on the parent dir, a file with DELETE can be
removed, a file w/o DELETE can't.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
