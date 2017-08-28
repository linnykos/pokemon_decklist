library(showtext)
#font.add.google("Schoolbell", "bell")
font.add.google("Bevan", "bevan")

## By default the automatic call of showtext is disabled
## You can manually turn it off using the line below
## showtext.auto(enable = FALSE)

## To use showtext.begin() and showtext.end() you need to
## explicitly open a graphics device
png("../coding_test/demo.png", 700, 600, res = 96)
set.seed(123)
x = rnorm(10)
y = 1 + x + rnorm(10, sd = 0.2)
y[1] = 5
mod = lm(y ~ x)

op = par(cex.lab = 1.5, cex.axis = 1.5, cex.main = 2)
plot(x, y, pch = 16, col = "steelblue",
     xlab = "X variable", ylab = "Y variable")
grid()

## Use showtext only for this part
showtext.begin()
title("Draw Plots Before You Fit A Regression", family = "bevan")
showtext.end()

text(-0.5, 4.5, "This is the outlier", cex = 2, col = "steelblue")
abline(coef(mod))
abline(1, 1, col = "red")
text(1, 1, expression(paste("True model: ", y == x + 1)),
     cex = 1.5, col = "red", srt = 20)
text(0, 2, expression(paste("OLS: ", hat(y) == 0.79 * x + 1.49)),
     cex = 1.5, srt = 15)
legend("topright", legend = c("Truth", "OLS"), col = c("red", "black"), lty = 1)

par(op)
dev.off()
