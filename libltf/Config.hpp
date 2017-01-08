#ifndef LTF_CONFIG_HPP_
#define LTF_CONFIG_HPP_

// Lower CmpF <- ProjB <- Mux, to circumvent a firm bug.
#define LOWER_CMPF_PROJB_MUX

// Lower CmpF <- ProjB <- Conv, to circumvent a firm bug. This shouldn't be
// needed anymore, because the firm bug should be fixed.
//#define LOWER_CMPF_PROJB_CONV

// Lower all mux nodes to control flow.
//#define LOWER_ALL_MUX

// Use pointer arithmetic instead of sel nodes for LLVMs getelementptr. This
// circumvents problems with the load-store optimization, when getelementptr is
// applied to a constant pointer that has been bitcast.
#define GEP_POINTER_ARITHMETIC

#endif /* LTF_CONFIG_HPP_ */
