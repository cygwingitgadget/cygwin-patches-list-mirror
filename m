From: "Paul K. Fisher" <pfisher@plexware.com>
To: "Cygwin Patches" <cygwin-patches@sourceware.cygnus.com>
Subject: [RFA]: add missing prototypes to pthread.h 
Date: Sun, 07 May 2000 20:30:00 -0000
Message-id: <000a01bfb89d$297b83c0$6401a8c0@jupiter>
X-SW-Source: 2000-q2/msg00041.html

Sun May  7 23:10:00 2000  Paul K. Fisher <pfisher@plexware.com>
	* include/pthread.h (pthread_detach): Add missing prototype.
	(pthread_join): same.
	

Index: pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 pthread.h
*** pthread.h	2000/02/17 19:38:31	1.1.1.1
--- pthread.h	2000/05/08 03:19:43
***************
*** 49,58 ****
  int pthread_attr_destroy (pthread_attr_t * attr);
  int pthread_attr_setstacksize (pthread_attr_t * attr, size_t size);
  int pthread_attr_getstacksize (pthread_attr_t * attr, size_t * size);
! /*
!  pthread_attr_setstackaddr(...);
!  pthread_attr_getstackaddr(...);
! */
  
  /* Thread Exit */
  int pthread_exit (void *value_ptr);
--- 49,58 ----
  int pthread_attr_destroy (pthread_attr_t * attr);
  int pthread_attr_setstacksize (pthread_attr_t * attr, size_t size);
  int pthread_attr_getstacksize (pthread_attr_t * attr, size_t * size);
! 
! /* Thread Control */
! int pthread_detach (pthread_t thread);
! int pthread_join (pthread_t thread, void **value_ptr);
  
  /* Thread Exit */
  int pthread_exit (void *value_ptr);
