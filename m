Return-Path: <cygwin-patches-return-3949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32120 invoked by alias); 12 Jun 2003 15:59:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32042 invoked from network); 12 Jun 2003 15:59:31 -0000
Message-ID: <3EE8A3DB.893CDD28@ieee.org>
Date: Thu, 12 Jun 2003 15:59:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com> <20030612152149.GB30116@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00176.txt.bz2

Corinna Vinschen wrote:
> 
> > You will see that cygwin_set_impersonation_token() should
> > now return a success/failure indication, instead of void.
> > That's not done yet, waiting for your opinion.
> 
> How do you intend to use that return value?

If changing the type to return a value is likely to break
existing applications, I would no do it.
The feedback is meant for application writers or porters 
who attempt to use the function in a way it was not designed 
for. The patch turns those calls into noops (with strace
output), which should suffice in practice. 

Pierre
