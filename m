Return-Path: <cygwin-patches-return-3311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22797 invoked by alias); 12 Dec 2002 16:33:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22775 invoked from network); 12 Dec 2002 16:33:13 -0000
Message-ID: <3DF8BA7A.37C82FE5@ieee.org>
Date: Thu, 12 Dec 2002 08:33:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00262.txt.bz2

Christopher Faylor wrote:
> 
> Actually, if you can get away without using a
> constructor that would be best.  Constructors are a noticeable part of
> cygwin's startup cost.

- Is there a C++ way to initialize a constant class and have it in the .text 
  section, as "const int i = 1;" would be?
- If not, I can get the desired effect by using gcc "Asm Labels", like
  int foo asm ("myfoo") = 2;
  Would that be acceptable in Cygwin?

Pierre
