Return-Path: <cygwin-patches-return-3481-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20892 invoked by alias); 3 Feb 2003 12:57:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20835 invoked from network); 3 Feb 2003 12:57:46 -0000
Date: Mon, 03 Feb 2003 12:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Minor ntsec fixes and optimizations.
Message-ID: <20030203125742.GD9587@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030131035949.007fae20@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030131035949.007fae20@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00130.txt.bz2

Hi Pierre,

On Fri, Jan 31, 2003 at 03:59:49AM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> I have a new patch ready against the chown bug, but it conflicts
> with what I sent a few days ago. In what order do you want to
> proceed?

honestly?  Ok, I'd like to see smaller patches which solve one problem
at a time, not these very big patches which take a disproportional time
to review.  I don't actually see a need to include name changes of
defines in the same patch which make the patch file even more larger.

If you could do me a favor, please send the whole patch in smaller chunks
which solve one problem at a time.  This allows me to review them bit by
bit in some of these spare moments...


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
