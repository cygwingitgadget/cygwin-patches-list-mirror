Return-Path: <cygwin-patches-return-3624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28313 invoked by alias); 25 Feb 2003 15:14:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28301 invoked from network); 25 Feb 2003 15:14:31 -0000
Message-ID: <3E5B88E9.24325E11@ieee.org>
Date: Tue, 25 Feb 2003 15:14:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: mkpasswd & mkgroup
References: <3.0.5.32.20030224232915.007f5530@mail.attbi.com> <20030225115847.GO1677@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00273.txt.bz2

Corinna Vinschen wrote:

> What is the impact for setup.exe?  In my eyes the change is fine
> and could be kept this way.  

OK, that's fine with me too. 

> It wouldn't require any change to
> setup.exe and *especially* it would'n be good to change mkpasswd
> and mkgroup for a short period of time just to revert the patch
> a few days (I'm an optimist) later.

I agree, but the impact on users is minimal, as long as the /etc/passwd
file is initialized correctly. 
The postinstall script passwd-grp.sh MUST be changed anyway for the new
setup and it is as easy to change it to "-l only" as to "-l -c"
(as written currently it would erroneously run as -d even on isolated
 workstations).
  
> So, either we just keep mkpasswd and mkgroup now as it is, or we
> make sure that setup.exe won't rely on the -c flag in the next
> version but just uses -l as today.

Fine, let's change mkpasswd. 

Pierre
