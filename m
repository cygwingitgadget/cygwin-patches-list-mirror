Return-Path: <cygwin-patches-return-2908-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5550 invoked by alias); 2 Sep 2002 05:35:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5470 invoked from network); 2 Sep 2002 05:35:09 -0000
Date: Sun, 01 Sep 2002 22:35:00 -0000
From:	Ville Herva <vherva@niksula.hut.fi>
To:	"Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: Unicode filename patch
Message-ID: <20020902053503.GZ2496@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHEEFHCLAA.chris@atomice.net>
User-Agent: Mutt/1.3.25i
X-SW-Source: 2002-q3/txt/msg00356.txt.bz2

On Sun, Sep 01, 2002 at 02:09:52PM +0100, you [Chris January] wrote:            
> > Hi,                                                                         
> >                                                                             
> > I haven't been able to follow cygwin ml for a while (too busy at            
> > work ;( ),                                                                  
> > but did Christopher Faylor ever consider merging the unicode                
> > filename patch                                                              
> > you created? I followed CVS for a while, but it didn't appear there (I      
> > haven't checked lately, though.)                                            
> Ask on cygwin-patches what Chris wants to do with it. It's best discussed     
> there.                                                                        
>                                                                               
> BTW, the patch is not complete; certain functions don't work. It's main       
> purpose was to allow reading and writing files with Unicode filenames -       
> something that wasn't possible at all before.                                 
>                                                                               
> Saying that, it did work quite well with UTF8 aware shell tools and a UTF8    
> terminal.                                                                     
                                                                                
cgf, to give you some context (I hope you read this :) : I originally begged    
for unicode filename support a couple of months ago. Chris January very         
kindly went ahead and implemented a patch that enabled accessing unicode        
filenames through their utf8 name.                                              
                                                                                
See the discussion in thread starting at                                        
http://sources.redhat.com/ml/cygwin/2002-07/msg00006.html.                      
                                                                                
The executive summary is that when one has unicode filenames (russian,          
chinese, whatever) it is currently not possible to access them _at_all_ with    
cygwin. Chris's patch makes it possible to do so.                               
                                                                                
But Chris (and I) haven't heard any comment from you or Corinna whether this    
is worthwhile...                                                                
                                                                                
                                                                                
-- v --                                                                         
                                                                                
v@iki.fi                                                                        
