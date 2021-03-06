
#ifndef _COMPAT_H_
#define _COMPAT_H_

char* fgetln (FILE *,  size_t *);
size_t strlcat(char *, const char *, size_t);
size_t strlcpy(char *, const char *, size_t);
long long strtonum(const char *, long long, long long, const char **);

#endif /* _COMPAT_H_ */
