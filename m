Return-Path: <cygwin-patches-return-3346-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15027 invoked by alias); 20 Dec 2002 01:39:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15017 invoked from network); 20 Dec 2002 01:39:18 -0000
Date: Thu, 19 Dec 2002 17:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021220013916.GA7359@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de> <20021216131554.D30600@hagbard.io.com> <20021216193629.GB19567@redhat.com> <20021216164704.A13198@fnord.io.com> <20021217035114.GA12993@redhat.com> <20021217013105.A22529@hagbard.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217013105.A22529@hagbard.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00297.txt.bz2

On Tue, Dec 17, 2002 at 01:31:05AM -0600, Steve O wrote:
>On Mon, Dec 16, 2002 at 10:51:14PM -0500, Christopher Faylor wrote:
>> One more question, though.  In accept_input, shouldn't ret be set to
>> something besides 1 when there is an "error writing to pipe"?
>
>True.  I hadn't been considering the error case. 
>I've attached a patch for this.  It's not terribly pretty. 

Thanks.  I've checked this in.  It didn't look too ugly to me.  I can't think
of any other way to do this.

I wrote a ChangeLog for this, too.  It helped me understand what you
were doing.

Thanks.

cgf
