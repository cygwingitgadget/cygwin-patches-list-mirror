Return-Path: <cygwin-patches-return-3244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8790 invoked by alias); 29 Nov 2002 18:06:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8775 invoked from network); 29 Nov 2002 18:06:13 -0000
Date: Fri, 29 Nov 2002 10:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Internal get{pw,gr}XX calls
Message-ID: <20021129190611.F1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com> <20021129184501.E1398@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129184501.E1398@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00195.txt.bz2

On Fri, Nov 29, 2002 at 06:45:01PM +0100, Corinna Vinschen wrote:
> That means:  If the id string is invalid or empty (stp == src) or the
> character after the number is not a colon (*stp != ':'), set src to the end of
> the string (*src == '\0'), else set src to the next character after

Reviewing the own mail before sending it seems to be a good idea.
That was the first idea, moving the src pointer.  Then I saw that
it's way easier to return -1.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
