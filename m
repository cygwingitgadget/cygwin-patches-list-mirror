Return-Path: <cygwin-patches-return-4347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22583 invoked by alias); 7 Nov 2003 18:31:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22574 invoked from network); 7 Nov 2003 18:31:11 -0000
Date: Fri, 07 Nov 2003 18:31:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] : make cygpath use multiple filename arguments
Message-ID: <20031107183110.GA3861@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FAA7D7F.9080408@fangorn.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAA7D7F.9080408@fangorn.ca>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00066.txt.bz2

On Thu, Nov 06, 2003 at 11:57:35AM -0500, Mark Blackburn wrote:
> This patch will allow you to do this.
> 
> $ ./cygpath.exe -w -a cygpath.cc cygpath.exe
> E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.cc
> E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.exe
> 
> I don't know if this is desired behaviour or not. Personally, I would
> find it useful.
> 
> Mark Blackburn

Applied.  Just a ChangeLog entry would have been nice ;-)

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
